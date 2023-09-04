class Item < ApplicationRecord

  belongs_to :user
  has_one_attached :image

  validates :image, presence: true
  validates :item_name, presence: true
  validates :item_info, presence: true
  validates :category_id, presence: true
  validates :item_status_id, presence: true
  validates :shipping_fee_status_id, presence: true
  validates :prefecture_id, presence: true
  validates :delivery_date_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :delivery_date

  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :item_status_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :shipping_fee_status_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :delivery_date_id, numericality: { other_than: 1 , message: "can't be blank"} 

end
