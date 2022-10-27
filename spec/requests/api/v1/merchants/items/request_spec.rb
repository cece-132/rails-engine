require 'rails_helper'

RSpec.describe "Merchant and items associations" do
  describe 'index' do
    it 'returns a merchants items' do
      merchant = create(:merchant)
      create_list(:item, 5, merchant_id: merchant.id)

      get "/api/v1/merchants/#{merchant.id}/items"
      
      merchant_items = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(merchant_items[:data].length).to eq 5
      expect(merchant_items[:data].first[:type]).to eq "item"

      merchant_items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item).to have_key(:type)
        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes]).to have_key(:merchant_id)
      end
    end

    it 'returns proper format if empty' do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}/items"

      merchant_items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq 200
      expect(merchant_items).to be_a Hash
      expect(merchant_items).to have_key(:data)
    end

    it 'returns 404 if merchant not found' do
      merchant = create(:merchant)
      create_list(:item, 5, merchant_id: merchant.id)

      get "/api/v1/merchants/76492/items"

      expect(response.status).to eq 404

      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response[:error]).to eq "Merchant Items not found"
    end
    
  end

end