class Concert < ActiveRecord::Base
  belongs_to :venue
  before_validation :generate_url
  has_many :concert_orders
  has_many :orders, through: :concert_orders

  validates_with AttachmentSizeValidator, attributes: :logo, less_than: 1.megabytes
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://static4.businessinsider.com/image/51783cd26bb3f7c826000009/this-is-the-best-way-to-buy-concert-tickets-on-your-iphone.jpg"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  def generate_url
    self.url = "#{date}-#{band.parameterize}"
  end
end
