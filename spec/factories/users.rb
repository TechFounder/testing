# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	sequence(:email){|n| "newuser#{n}@example.com" }
    password "test1234"
    password_confirmation "test1234"
  end
end
