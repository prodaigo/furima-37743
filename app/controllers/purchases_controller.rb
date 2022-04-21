class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_params
  before_action :move_to_index

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number).merge(token: params[:token], user_id: current_user.id, item_id: @item.id)
  end

  def find_params
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    redirect_to root_path if (current_user.id == @item.user_id) || @item.purchase.present?
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
