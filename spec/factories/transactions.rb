FactoryBot.define do
  factory :transaction do
    listing { nil }
    lender_id { "" }
    borrower_id { "" }
    start_date { "2025-08-08" }
    end_date { "2025-08-08" }
    status { 1 }
  end
end
