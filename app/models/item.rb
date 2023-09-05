class Item < ApplicationRecord
  validates :image,                 presence: true
  validates :item_name,             presence: true, length: { minimum: 1, maximum: 40 }
  validates :item_info,             presence: true, length: { minimum: 1, maximum: 1000 }
  validates :price,                 numericality: { only_integer: true , greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :category_id,           numericality: { other_than: 1 , message: "can't be blank"} 
  validates :sales_status_id,       numericality: { other_than: 1 , message: "can't be blank"} 
  validates :shipping_fee_id,       numericality: { other_than: 1 , message: "can't be blank"} 
  validates :prefecture_id,         numericality: { other_than: 1 , message: "can't be blank"} 
  validates :scheduled_delivery_id, numericality: { other_than: 1 , message: "can't be blank"} 

  belongs_to :user
  has_one_attached :image
  has_one :purchase

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :prefecture
  belongs_to :sales_status
  belongs_to :scheduled_delivery
  belongs_to :shipping_fee

end
