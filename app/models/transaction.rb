class Transaction < ApplicationRecord
  belongs_to :listing
  belongs_to :lender, class_name: "User"
  belongs_to :borrower, class_name: "User"
  has_one :message, as: :messageable, dependent: :nullify

  enum :status, {pending: 0, in_progress: 1, completed: 2, cancelled: 3}

  validates :lender_id, comparison: {other_than: :borrower_id}

  after_save :sync_listing_status, if: :saved_change_to_status?
  validates :end_date, presence: true, if: -> { listing&.listing_type == "Lend" }
  validates :start_date, comparison: {less_than_or_equal_to: :end_date}, if: -> { start_date.present? && end_date.present? }
  validates :end_date, comparison: {greater_than_or_equal_to: Date.current}, if: -> { end_date.present? }

  private

  def sync_listing_status
    case status.to_sym
    when :in_progress
      # Lend starts or sell implicitly progresses -> make item unavailable
      listing.update(status: "Unavailable")
    when :completed
      if listing.listing_type == "Lend"
        listing.update(status: "Available")
      else # Sell
        listing.update(status: "Unavailable")
      end
    when :cancelled
      # If a lend was cancelled and not completed, make available again
      if listing.listing_type == "Lend"
        listing.update(status: "Available")
      end
    end
  end
end
