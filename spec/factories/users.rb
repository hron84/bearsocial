# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) { "John Doe @ #{n}" }
  	sequence(:email) { |n| "johndoe.#{n}@example.com" }
    password "S3cretPass!"
    password_confirmation "S3cretPass!"
  	confirmed_at { Time.now }
  	admin false
    avatar_url "http://www.gravatar.com/avatar/00000000000000000000000000000000.png"
    slogan "Lorem ipsum dolor sit amet, adespicing elit?"
  end

  factory :admin, :class => User do
    sequence(:name) { "Jack Doe @ #{n}" }
  	sequence(:email) { |n| "jackdoe.#{n}@example.com" }
    password "V3r4S3cretPass!"
    password_confirmation "V3r4S3cretPass!"
  	confirmed_at { Time.now }
  	admin true
  end
end
