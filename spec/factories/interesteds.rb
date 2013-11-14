# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :interested do
    user nil
    interested_obj_id 1
    interested_obj_type "MyString"
  end
end
