# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    item_id 1
    quantity 1
    customer_id 1
    stripe_transaction_id "MyString"
  end
end
