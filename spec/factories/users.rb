# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "newuser#{n}@example.com" }
    password "password456"
    password_confirmation "password456"
  end
end
