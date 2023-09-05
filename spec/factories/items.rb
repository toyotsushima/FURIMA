FactoryBot.define do
  factory :item do
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
    item_name                  { '商品名' }
    item_info                  { '商品の説明' }
    item_status_id              { 2 }
    shipping_fee_status_id      { 2 }
    prefecture_id               { 2 }
    category_id                 { 2 }
    delivery_date_id            { 2 }
    price                       { 2000 }

    association :user, factory: :user
  end
end
