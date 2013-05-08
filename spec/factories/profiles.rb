# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    user
    enable_title true
    phone "+36 20 234 5687"
    jabber_id "joe.smith@example.com"
    skype_id "joe.smith256"
    twitter_id "jsmith"
  end
end
