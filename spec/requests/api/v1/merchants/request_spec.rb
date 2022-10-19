require 'rails_helper'

RSpec.describe "Items API" do
  
  describe 'sends a list of merchants' do
    it 'sends merchant info' do
      create_list(:merchant, 10)
      create_list(:item, 3, merchant_id: Merchant.first.id)

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants).to be_a Hash
      expect(merchants).to have_key(:data)
      expect(merchants[:data]).to be_a Array
      expect(merchants[:data].count).to eq 10

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a String

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a String

        expect(merchant).to have_key(:attributes)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a String
      end
    end

    it 'sends an array even if blank' do

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants).to have_key(:data)
      expect(merchants[:data]).to be_a Array
      expect(merchants[:data].count).to eq 0
    end
  end

  describe 'send a single merchant' do
    it 'sends the merchant w/ id' do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant).to be_a(Hash)
      expect(merchant).to have_key(:data)
      expect(merchant[:data]).to be_a Hash

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data]).to have_key(:attributes)
      
      expect(merchant[:data][:id]).to be_a(String)
      expect(merchant[:data][:attributes]).to be_a(Hash)

      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
    end

    it 'sad path, bad integer id returns 404'
    it 'edge case, string id returns 404'
  end
end