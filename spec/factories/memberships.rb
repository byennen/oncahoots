# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :membership do
    user_id 1
    university_id 1
    admin false
    manager false
  end
end
