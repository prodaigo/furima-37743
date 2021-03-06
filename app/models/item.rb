class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase
  # has_many :comments
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :shipment_date

  with_options presence: true do
    validates :name
    validates :description
    validates :image
    with_options numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 } do
      validates :price
    end
    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :category_id
      validates :condition_id
      validates :delivery_charge_id
      validates :prefecture_id
      validates :shipment_date_id
    end
  end
end
