class Concert < ActiveRecord::Base
  belongs_to :venue
  before_validation :generate_url
  has_many :concert_orders
  has_many :orders, through: :concert_orders

  validates :logo, attachment_presence: true
  validates_with AttachmentPresenceValidator, attributes: :logo
  validates_with AttachmentSizeValidator, attributes: :logo, less_than: 1.megabytes
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  def generate_url
    self.url = "#{date}-#{band.parameterize}"
  end
end
