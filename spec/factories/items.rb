FactoryBot.define do
  factory :item do
    image {Faker::Lorem.sentence}
    name          {"商品名"}
    introduction    {"説明"}
    item_status_id              {1}
    shipping_fee_status_id      {1}
    prefecture_id               {1}
    prepare_id                  {1}
    delivery_date_id            {1}
    price                       {2000}
    association :user
  end
end
