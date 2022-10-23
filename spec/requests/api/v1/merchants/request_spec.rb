require 'rails_helper'

RSpec.describe "Merchant API" do
  describe 'index' do
    it 'retuns all merchants' do
      create_list(:merchant, 10)

      get "/api/v1/merchants"

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants).to be_a Hash
      expect(merchants).to have_key(:data)
      expect(merchants[:data]).to be_a Array

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a(String)

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_a(Hash)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

  end

  describe 'show' do
    it 'lists one mechant' do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant).to be_a Hash
      expect(merchant).to have_key(:data)
      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data]).to have_key(:type)
      expect(merchant[:data]).to have_key(:attributes)
      expect(merchant[:data][:attributes]).to have_key(:name)
    end
  end

end