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

  scope :filter_name, -> (name) { where(['name ILIKE ? OR description = ?', "%#{name}%", "%#{name}%"]) }
  scope :filter_max_price, -> (max_price) { where('unit_price <= ?', max_price).order(:name) }
  scope :filter_min_price, -> (min_price) { where('unit_price >= ?', min_price).order(:name) }

  private

  def cleanup
    x = Invoice.left_joins(:invoice_items)
    .select('invoices.*, count(invoice_items) as total_inv')
    .having('count(invoice_items) = ?', 0)
    .group(:id)
    .destroy_all
  end

end