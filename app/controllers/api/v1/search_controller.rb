class Api::V1::SearchController < ApplicationController

  def find_item
    search_item = Item.find_one_item(params[:name])
    if search_item.nil?
      render json: ItemSerializer.format_item(search_item), status: :not_found
    else
      render json: ItemSerializer.format_item(search_item)
    end
  end

end