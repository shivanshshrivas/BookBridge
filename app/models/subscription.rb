class Subscription < ApplicationRecord
  belongs_to :user
  validates :query_params, presence: true
end
