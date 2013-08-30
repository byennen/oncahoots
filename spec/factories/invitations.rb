# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    sender_id 1
    recipient_id 1
    token "MyString"
    sent_at "2013-08-30 03:27:46"
    new "MyString"
  end
end
