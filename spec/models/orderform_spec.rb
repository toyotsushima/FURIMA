require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @orderform = FactoryBot.build(:order_form, user_id: @user.id, item_id: @item.id)
    sleep 0.1 
  end

  describe '購入者情報の保存' do
    context '購入者情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@orderform).to be_valid
      end
      it 'buildingが空でも保存できる' do
        @orderform.building = nil
        expect(@orderform).to be_valid
      end
    end

    context '購入者情報の保存ができないとき' do
      it 'user_idが空だと保存できない' do
        @orderform.user_id = nil
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できない' do
        @orderform.item_id = nil
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Item can't be blank")
      end
      it 'postal_codeが空だと保存できない' do
        @orderform.postal_code = nil
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeにハイフンがないと保存できない' do
        @orderform.postal_code = 1_234_567
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'postal_codeが3桁-4桁でなければ保存できない' do
        @orderform.postal_code = 1234 - 56_789
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefecture_idが未選択だと出品できない' do
        @orderform.prefecture_id = 0
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できない' do
        @orderform.city = nil
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空だと保存できない' do
        @orderform.address = nil
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空だと保存できない' do
        @orderform.phone_number = nil
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberにハイフンがあると保存できない' do
        @orderform.phone_number = '090-1234-5678'
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが12桁以上あると保存できない' do
        @orderform.phone_number = 123_456_789_101_234
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが9桁以下であると保存できない' do
        @orderform.phone_number = 123_456_789
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenが空では登録できないこと' do
        @orderform.token = nil
        @orderform.valid?
        expect(@orderform.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
