class ItemsController < ApplicationController
  require 'payjp'

  def index
  end

  def show
  end

  def new
    @item = Item.new
    @item.item_images.new
  end

  def create
    binding.pry
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :introduce, :brand_id, :size_id, :commodity_condition_id, :shipping_charge_id, :shipping_mathod_id,:prefecture_id, :shipping_day_id, item_images_attributes: [:image])
    # params.require(:item).require(:item_images_attributes).require(:"0").permit(:image)
  end

  def purchase
    # Payjp.api_key = "sk_test_322f9158a6159e107c587430"
    # Payjp::Charge.create(
    #   amount: 111,
    #   card: params['payjp-token'],
    #   currency: 'jpy'
    # )
    # redirect_to root_path, notice: "支払いが完了しました"
    binding.pry
    Payjp.api_key = "sk_test_322f9158a6159e107c587430"
    Payjp::Charge.create(currency: 'jpy', amount: 111, card: params['payjp-token'])
    redirect_to root_path, notice: "支払いが完了しました"
  end

end
