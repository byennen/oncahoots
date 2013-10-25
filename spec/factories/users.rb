# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name 'Test'
    last_name 'User'
    sequence(:email) { |n| "example#{n}@example.com" }
    university
    graduation_year '2005'
    major 'computer engineering'
    password 'changeme'
    password_confirmation 'changeme'
    university_id '1'
    city_id 1
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end
