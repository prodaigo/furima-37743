require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '商品購入' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)
    end

    context '購入できるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@purchase_address).to be_valid
      end
      it '建物名は空でも保存できる' do
        @purchase_address.building = nil
        expect(@purchase_address).to be_valid
      end
    end

    context '購入できないとき' do
      it '郵便番号が空だと保存できない' do
        @purchase_address.postcode = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postcode can't be blank")
      end
      it '郵便番号が半角のハイフンを含んだ正しい形式でないと保存できない' do
        @purchase_address.postcode = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postcode is invalid. Include hyphen(-)")
      end
      it '郵便番号が全角数字では保存できない' do
        @purchase_address.postcode = '１２３−４５６７'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postcode is invalid. Include hyphen(-)")
      end
      it '都道府県が空だと保存できない' do
        @purchase_address.prefecture_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県を選択していないと保存できない' do
        @purchase_address.prefecture_id = '1'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture Select")
      end
      it '市区町村が空だと保存できない' do
        @purchase_address.city = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できない' do
        @purchase_address.block = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Block can't be blank")
      end
      it '電話番号が空だと保存できない' do
        @purchase_address.phone_number = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が9桁以下の半角数値では保存できない' do
        @purchase_address.phone_number = '123456789'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number Input only number(min: 10, max: 11)")
      end
      it '電話番号が12桁以上の半角数値では保存できない' do
        @purchase_address.phone_number = '123456789012'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number Input only number(min: 10, max: 11)")
      end
      it '電話番号が全角数字では保存できない' do
        @purchase_address.phone_number = '１２３４５６７８９０'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number Input only number(min: 10, max: 11)")
      end
      it '電話番号が半角のハイフンを含んでいると保存できない' do
        @purchase_address.phone_number = '123-4567-8901'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number Input only number(min: 10, max: 11)")
      end
      it 'userが紐付いていなければ購入できない' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include()
      end
      it 'itemが紐付いていなければ購入できない' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include()
      end
      it "tokenが空では購入できない" do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
