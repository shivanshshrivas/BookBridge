FactoryBot.define do
  factory :message do
    listing { nil }
    sender_id { "" }
    receiver_id { "" }
    messageable { nil }
  end
end
