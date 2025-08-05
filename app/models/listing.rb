class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :saved_items, dependent: :destroy
  has_many :saved_by_users, through: :saved_items, source: :user

  validates :title, :authors, :description, :listing_type, :university, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0}, allow_nil: true

  def self.ransackable_attributes(auth_object = nil)
    %w[title authors listing_type price isbn course_number university updated_at created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[images_attachments images_blobs user]
  end
end
