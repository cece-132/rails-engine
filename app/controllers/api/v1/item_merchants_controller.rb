class Api::V1::ItemMerchantsController < ApplicationController

  def show
    item = Item.find(params[:item_id])
    render json: MerchantSerializer.format_merchant(item.merchant)
  end

end