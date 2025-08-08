class Message < ApplicationRecord
  belongs_to :listing
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :messageable, polymorphic: true

  validates :participants_are_distinct

  scope :between, ->(u1, u2, listing_id) {
    where(listing_id:, sender_id: [u1, u2], receiver_id: [u1, u2]).order(:created_at)
  }

  def other_party_for(user) = (user.id == sender_id) ? receiver : sender

  private

  def participants_are_distinct
    if sender_id == receiver_id
      errors.add(:base, "Sender and receiver must be distinct users")
    end
  end
end
