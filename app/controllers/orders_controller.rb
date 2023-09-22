class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :sold_item, only: [:index, :create]

  def index
    @orderform = OrderForm.new
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def create
    @orderform = OrderForm.new(order_params)
    if @orderform.valid?
      pay_item
      @orderform.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def move_to_index
    redirect_to new_user_session_path unless user_signed_in?
  end

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

  def sold_item
    @item = Item.find(params[:item_id])
    return unless current_user.id == @item.user_id || @item.order.present?

    redirect_to root_path
  end
end
