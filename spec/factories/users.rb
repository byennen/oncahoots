# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name 'Test'
    last_name 'User'
    email 'example@example.com'
    university 'Iowa'
    graduation_year '2005'
    major 'computer engineering'
    password 'changeme'
    password_confirmation 'changeme'
    university_id '1'
    city 'Chicago'
    state 'IL'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end