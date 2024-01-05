class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @cart_items = current_customer
  end
  
  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if @current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.quantity += params[:cart_item][:quantity].to_i
      @cart_item.save
      redirect_to public_cart_items_path
    elsif @cart_item.save
      @cart_items = current_customer.cart_items.all
      redirect_to public_cart_items_path
    else
      render root_path
    end
  end
  
  private

  def cart_item_params
    params.require(:cart_items).permit(:item_id,:customer_id, :amount)
  end  
end
