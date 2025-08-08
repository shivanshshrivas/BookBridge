class TextMessage < ApplicationRecord
  has_one :message, as: :messageable, dependent: :destroy
  validates :content, presence: true, length: {maximum: 3000}
end
