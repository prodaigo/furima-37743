require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '出品できるとき' do
      it '全項目が存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '出品できないとき' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'descriptionが空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'categoryが空では出品できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'conditionが空では出品できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it 'delivery_chargeが空では出品できない' do
        @item.delivery_charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge can't be blank")
      end
      it 'prefectureが空では出品できない' do
        @item.prefecture_id  = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'shipment_dateが空では出品できない' do
        @item.shipment_date_id  = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipment date can't be blank")
      end
      it 'priceが空では出品できない' do
        @item.price  = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが299円以下では出品できない' do
        @item.price  = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it 'priceが10,000,000円以上では出品できない' do
        @item.price  = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it 'priceが全角数字では出品できない' do
        @item.price  = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end
  end
end
