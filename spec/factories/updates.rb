# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :update do
    body "MyText"
    updateable_id 1
    updateable_type "MyString"
  end
end
