class Api::V1::Items::MerchantController < ApplicationController
  def show
    item = Item.find(params[:id])
    if Item.exists?(item.id)
      merchant = item.merchant
      render json: MerchantSerializer.new(merchant)
    else
      render json: { error: 'Items Merchant not found' }, status: 404
    end
  end
end