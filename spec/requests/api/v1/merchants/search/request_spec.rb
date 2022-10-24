require 'rails_helper'

RSpec.describe 'Merchant Search' do
  describe 'find' do
    it 'can find merchant by name' do
      merch_1 = create(:merchant, name: 'First Name')
      merch_2 = create(:merchant, name: 'Second Name')
      merch_3 = create(:merchant, name: 'Third Name')

      get '/api/v1/merchants/find?name=name'

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant).to be_a Hash
      expect(merchant).to have_key(:data)
      expect(merchant[:data]).to be_a Hash
      expect(merchant[:data][:id]).to eq "#{merch_1.id}"
    end
  end

  describe 'find_all' do
    it 'can find all the merchants by name' do
      merch_1 = create(:merchant, name: 'First Name')
      merch_2 = create(:merchant, name: 'Second Name')
      merch_3 = create(:merchant, name: 'Third Name')

      get '/api/v1/merchants/find_all?name=name'

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant).to be_a Hash
      expect(merchant).to have_key(:data)
      expect(merchant[:data]).to be_a Array
      expect(merchant[:data].count).to eq 3
    end
  end
end