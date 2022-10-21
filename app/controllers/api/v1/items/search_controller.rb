class Api::V1::Items::SearchController < ApplicationController

  def find
    items = Item.where(nil)
    if name_and_price(params)
      render json: { data: {}, error: 'error' }, status: 400
    elsif min_and_max_price(params)
      @item = items.filter_min_price(params[:min_price]).filter_max_price(params[:max_price])
      if @item.present?
        render json: ItemSerializer.new(@item)
      else
        render json: { data: {}, error: 'error' }, status: 400
      end
    else 
      name_min_max(params).each do |k,v|
        @item = items.public_send("filter_#{k}", v) if !v.empty? && !v.to_f.negative? 
      end
      if @item.present?
        render json: ItemSerializer.new(@item)
      else
        render json: { data: {}, error: 'error' }, status: 400
      end
    end
  end

  private

  def name_and_price(params)
    params[:name] && params[:min_price] || params[:name] && params[:max_price]
  end

  def min_and_max_price(params)
    params[:min_price] && params[:max_price]
  end

  def name_min_max(params)
    params.slice(:name, :min_price, :max_price)
  end

end

#     if params[:name].present?
#       search_item = Item.find_one_item(params[:name])
#       render json: ItemSerializer.new(search_item)

#     elsif params[:min_price].present? && params[:max_price].present?
#       items = Item.price_between(params[:max_price].to_f.abs, params[:min_price].to_f.abs)
#       render json: ItemSerializer.new(items)

#     elsif params[:min_price].present?
#       items = Item.greater_than_min_price(params[:min_price].to_f.abs)
#       render json: ItemSerializer.new(items)

#     elsif params[:max_price].present?
#       items = Item.less_than_max_price(params[:max_price].to_f.abs)
#       render json: ItemSerializer.new(items)
# binding.pry
#     end