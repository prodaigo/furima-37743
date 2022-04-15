class Item < ApplicationRecord
  
  belongs_to :user
  # has_one :purchase
  # has_many :comments
  # has_one_attached :image
  
  with_options presence: true do
    validates :name
    validates :description
    validates :price
    validates :category_id
    validates :condition_id
    validates :delivery_charge_id
    validates :prefecture_id
    validates :shipment_date_id
    # validates :image
  end
end
