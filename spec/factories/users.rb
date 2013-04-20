# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	name "John Doe"
  	sequence(:email) { |n| "johndoe.#{n}@example.com" }
  	password "secret"
  	password_confirmation "secret"
  	confirmed_at { Time.now }
  	admin false
  end

  factory :admin, :class => User do
  	name "Jack Doe"
  	sequence(:email) { |n| "jackdoe.#{n}@example.com" }
  	password "verysecret"
  	password_confirmation "verysecret"
  	confirmed_at { Time.now }
  	admin true
  end
end
