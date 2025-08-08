class Transaction < ApplicationRecord
  belongs_to :listing
  belongs_to :lender, class_name: "User"
  belongs_to :borrower, class_name: "User"
  has_one :message, as: :messageable, dependent: :nullify

  enum :status, {pending: 0, in_progress: 1, completed: 2, cancelled: 3}

  validate :parties_are_distinct

  private

  def parties_are_distinct
    if lender_id == borrower_id
      errors.add(:base, "Lender and borrower must be distinct users")
    end
  end
end
