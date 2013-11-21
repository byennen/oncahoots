# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stripe_credential do
    owner_id "MyString"
    integer "MyString"
    owner_type "MyString"
    stripe_publishable_key "MyString"
    token "MyString"
    uid "MyString"
  end
end
