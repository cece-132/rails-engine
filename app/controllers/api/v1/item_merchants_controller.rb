class Api::V1::ItemMerchantsController < ApplicationController

  def show
    item = Item.find(params[:item_id])
    render json: ItemMerchantSerializer.format_item_merchant(item, item.merchant)
  end

end