class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :title, :authors, :description, :listing_type, :university, presence: true
end
