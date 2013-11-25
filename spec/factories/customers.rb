# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    club nil
    user nil
    stripe_id "MyString"
  end
end
