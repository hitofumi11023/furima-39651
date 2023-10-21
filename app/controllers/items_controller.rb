class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def show
    @comments = @item.comments.includes(:user)
    @comment = Comment.new
  end

  def edit
    unless  current_user.id == @item.user.id && @item.purchase.nil?
      redirect_to root_path
    end
    unless user_signed_in?  
      redirect_to new_user_session_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if user_signed_in? && current_user.id == @item.user.id
      @item.destroy
      redirect_to root_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :item_info, :category_id, :sales_status_id, :shipping_fee_id, :prefecture_id, :scheduled_delivery_id, :price, :image).merge(user_id: current_user.id)
  end

end
