class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :title, :authors, :description, :listing_type, :university, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[title authors listing_type isbn course_number university updated_at]
  end
end
