class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  validates :image, presence: true
  validates :item_name, presence: true
  validates :item_info, presence: true
  validates :category_id, presence: true
  validates :item_status_id, presence: true
  validates :shipping_fee_status_id, presence: true
  validates :prefecture_id, presence: true
  validates :delivery_date_id, presence: true, numericality: { other_than: 1, message: 'Select' }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :price, numericality: { only_integer: true, message: 'Half-width number.' }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :delivery_date
  belongs_to_active_hash :item_status
  belongs_to_active_hash :category

  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :item_status_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_fee_status_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_date_id, numericality: { other_than: 1, message: "can't be blank" }
end
