class Concert < ActiveRecord::Base
  belongs_to :venue
  before_validation :generate_url
  has_many :concert_orders
  has_many :orders, through: :concert_orders

  def generate_url
    self.url = "#{date}-#{band.parameterize}"
  end
end
