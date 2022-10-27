class Api::V1::Items::SearchController < ApplicationController

  def find
    items = Item.where(nil)
    if name_and_price(params)
      render json: { data: {}, error: 'error' }, status: 400
    elsif min_and_max_price(params)
      @item = items.filter_min_price(params[:min_price]).filter_max_price(params[:max_price]).first
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
        render json: ItemSerializer.new(@item.first)
      else
        render json: { data: {}, error: 'error' }, status: 400
      end
    end
  end

  def find_all
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
        render json: { data: [], error: 'error' }, status: 400
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