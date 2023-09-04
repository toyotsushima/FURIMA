require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品情報入力' do
    context '商品の出品ができる場合' do
      it '全ての値が正しく入力されていれば出品できること' do
        expect(@item).to be_valid
      end
    end
    context '商品の出品ができない場合' do
      it 'imageが空だと出品できない' do
        @item.image = ""
        @item.valid?
        expect(@item.errors.full_messsages).to include("Image can't be blank")
      end
      it 'item_nameが空だと出品できない' do
        @item.item_name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'item_infoが空だと出品できない' do
        @item.item_info = ""
        @item.valid?
        expect(@item.errors.full_messsages).to include("Item info can't be blank")
      end
      it 'category_idが未選択だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messsages).to include("Category  can't be blank")
      end
      it 'item_status_idが未選択だと出品できない' do
        @item.item_status_id = 1
        @item.valid?
        expect(@item.errors.full_messsages).to include("Item status can't be blank")
      end
      it 'shipping_fee_status_idが未選択だと出品できない' do
        @item.shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messsages).to include("Shipping fee status can't be blank")
      end
      it 'prefecture_idが未選択だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messsages).to include("Prefecture can't be blank")
      end
      it 'delivery_date_idが未選択だと出品できない' do
        @item.delivery_date_id = 1
        @item.valid?
        expect(@item.errors.full_messsages).to include("Delivery date can't be blank")
      end
      it 'priceが空だと出品できない' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messsages).to include("Price can't be blank")
      end
      it 'priceが全角数字だと出品できない' do
        @item.price = "３００"
        @item.valid?
        binding.pry
        expect(@item.errors.full_messsages).to include("price 半角数字を使用してください")
      end
    end
  end
end

end
