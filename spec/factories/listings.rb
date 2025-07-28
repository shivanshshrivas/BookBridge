FactoryBot.define do
  factory :listing do
    user { nil }
    isbn { "MyString" }
    title { "MyString" }
    authors { "MyString" }
    edition { "MyString" }
    course_number { "MyString" }
    description { "MyText" }
    listing_type { "MyString" }
    price { 1.5 }
    status { "MyString" }
    university { "MyString" }
  end
end
