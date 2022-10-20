class Invoice < ApplicationRecord
  enum status: ["In Progress", "Completed", "Cancelled"]
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items, counter_cache: true

  # def self.cleanup
  #   binding.pry
  # end
end