# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :university_event do
    club_id 1
    title "MyString"
    time "MyString"
    date "MyString"
    location "MyString"
    description "MyString"
    category "MyString"
    image "MyString"
  end
end
