class Api::V1::ItemsController < ApplicationController

  def index
    items = Item.all
    render json: ItemSerializer.format_items(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.format_item(item)
  end

  def create
    render json: ItemSerializer.format_item(Item.create(item_params)), status: 201
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

end