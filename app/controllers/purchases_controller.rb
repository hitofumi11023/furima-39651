class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_purchase, only: [:index, :create]

  def index 
    if user_signed_in?
      if current_user.id == @item.user.id 
        redirect_to root_path
      elsif @item.purchase.present?
        redirect_to root_path
      else
        gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
        @purchase_address =  PurchaseAddress.new
      end
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @purchase_address =  PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  def set_purchase
    @item = Item.find(params[:item_id])
  end

  private

  def purchase_params 
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: purchase_params[:token],  # カードトークン
      currency: 'jpy'                  # 通貨の種類（日本円）
    )
  end
end

