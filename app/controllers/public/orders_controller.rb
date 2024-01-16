class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)

    if params[:order][:select_address] == "1"
      @order.ship_postalcode = current_customer.postal_code
      @order.ship_address = current_customer.address
      @order.ship_name = current_customer.first_name + current_customer.last_name

    ## 登録済住所実装したときは以下に変更する
    # elsif [:order][:select_address] == "2"
    #   @order = Order.new(order_params)
    #   @address = Address.find(params[:order][:address_id])
    #   @order.postal_code = @address.postal_code
    #   @order.address = @address.address
    #   @order.name = @address.name

    elsif params[:order][:select_address] == "3"
      @order.customer_id = current_customer.id
    end

    @cart_items = current_customer.cart_items
    @order_new = Order.new
    render :confirm
    # redirect_to orders_confirm_path
  end

  def complete

  end

  def create
    @order = Order.new(order_params)
    @order.customer_id
    @order.save

    @cart_items = current_customer.cart_items.all

    CartItem.destroy_all
    redirect_to public_orders_complete_path
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.where(order_id: @order.id)
  end

  private
  
  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :ship_postalcode, :ship_address, :ship_name, :payment_amount, :postage)
  end
end
