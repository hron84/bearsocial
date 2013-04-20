# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Test title #{n}" }
    body "Test content"
    author_id 1
    published true
    deleted false
  end
end
