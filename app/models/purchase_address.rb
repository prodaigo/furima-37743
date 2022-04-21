class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :postcode, :prefecture_id, :city, :block, :building, :phone_number, :purchase_id

  with_options presence: true do
    validates :token
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1, message: "Select" }
    validates :city
    validates :block
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'Input only number(min: 10, max: 11)' }
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, building: building, phone_number: phone_number, purchase_id: purchase.id)
  end
end