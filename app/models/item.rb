class Item < ApplicationRecord
  validates :name, uniqueness: {case_sensitive: false}

  enum status: ["Enabled", "Disabled"]
  belongs_to :merchant
  has_many :invoice_items, :dependent => :destroy
  has_many :invoices, through: :invoice_items
  has_many :items, through: :invoice_items

  after_destroy :cleanup

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  private

  def cleanup
    Invoice.left_joins(:invoice_items)
    .select('invoices.*, count(invoice_items) as total_inv')
    .having('count(invoice_items) = ?', 0)
    .group(:id)
    .destroy_all
  end

end