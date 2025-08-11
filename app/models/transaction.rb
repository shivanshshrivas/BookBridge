class Transaction < ApplicationRecord
  belongs_to :listing
  belongs_to :lender, class_name: "User"
  belongs_to :borrower, class_name: "User"
  has_one :message, as: :messageable, dependent: :nullify

  enum :status, {pending: 0, in_progress: 1, completed: 2, cancelled: 3}

  validate :parties_are_distinct
  validate :lend_requires_end_date

  private

  def lend_requires_end_date
    return unless listing&.listing_type == "Lend"
    errors.add(:end_date, "is required for lend") if end_date.blank?
    # Optional: if already started, ensure start <= end
    if start_date.present? && end_date.present? && start_date > end_date
      errors.add(:start_date, "must be before end date")
    end
  end

  def parties_are_distinct
    if lender_id == borrower_id
      errors.add(:base, "Lender and borrower must be distinct users")
    end
  end
end
