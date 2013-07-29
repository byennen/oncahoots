# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    major "MyString"
    skills "MyText"
    education "MyString"
    experience "MyText"
  end
end
