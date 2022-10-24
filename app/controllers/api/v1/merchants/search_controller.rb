class Api::V1::Merchants::SearchController < ApplicationController

  def find
    merchants = Merchant.where(nil)
    @merchant = merchants.filter_name(params[:name])
    if @merchant.present?
      render json: MerchantSerializer.new(@merchant.first)
    else
      render json: { data: {}, error: 'error' }, status: 400
    end
  end

  def find_all
    merchants = Merchant.where(nil)
    @merchants = merchants.filter_name(params[:name])
    if @merchants.present?
      render json: MerchantSerializer.new(@merchants)
    else
      render json: { data: [], error: 'error' }, status: 400
    end
  end
  
end 