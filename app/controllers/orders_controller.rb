class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    @orderform = OrderForm.new
  end

  def create
    @orderform = OrderForm.new(order_params)
    @item = Item.find(params[:item_id])
    if @orderform.valid?
        @orderform.save
        redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def move_to_index
    redirect_to new_user_session_path unless user_signed_in?
  end

  def order_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end


end
