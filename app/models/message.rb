class Message < ApplicationRecord
  belongs_to :listing
  belongs_to :messageable, polymorphic: true
end
