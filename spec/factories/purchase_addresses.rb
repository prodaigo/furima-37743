FactoryBot.define do
  factory :purchase_address do
    postcode      { '123-4567'}
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city          { Faker::Address.city }
    block         { Faker::Address.street_name }
    building      { Faker::Address.street_address }
    phone_number  { Faker::Number.number(digits: 10) }
  end
end
