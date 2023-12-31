class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :sold_item, only: [:index, :create]
  before_action :pay_key, only: [:index, :create]

  def index
    @orderform = OrderForm.new
    pay_key
  end

  def create
    @orderform = OrderForm.new(order_params)
    if @orderform.valid?
      pay_item
      @orderform.save
      redirect_to root_path
    else
      pay_key
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def pay_key
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def sold_item
    @item = Item.find(params[:item_id])
    return unless current_user.id == @item.user_id || @item.order.present?

    redirect_to root_path
  end
end
