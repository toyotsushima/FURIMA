FactoryBot.define do
  factory :order_form do
    postal_code { '111-1111' }
    prefecture_id { 2 }
    city { '横浜市緑区' }
    address { '青山1-1-1' }
    building { '柳ビル103' }
    phone_number { Faker::Number.decimal_part(digits: 11) }
    token { 'tok_abcdefghijk00000000000000000' }
    association :user, factory: :user
    association :item, factory: :item
  end
end
