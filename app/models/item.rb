class Item < ApplicationRecord
  enum status: ["Enabled", "Disabled"]
  belongs_to :merchant
  has_many :invoice_items, :dependent => :destroy
  has_many :invoices, through: :invoice_items, counter_cache: true
  has_many :items, through: :invoice_items, counter_cache: true
  # after_destroy :cleanup
  

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  private
  # def cleanup
  #   Invoice.cleanup
  # end
end