class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin! 
  
  def new
    @item = Item.new
  end

  def index
    @items = Item.page(params[:page])
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "商品を登録しました"
      redirect_to admin_item_path(@item.id)
    else
      render "new"
    end
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image)
  end
end
