class Concert < ActiveRecord::Base
  belongs_to :venue
  before_validation :generate_url
  has_many :concert_orders
  has_many :orders, through: :concert_orders
  belongs_to :category

  scope :band, ->(band) { where("band LIKE '%#{band}%'") }

  scope :date, ->(text_date) {
    text_date.empty? ? all : where(date: Date.strptime(text_date, "%Y-%m-%d"))
  }

  scope :city, ->(city) {
    city.empty? ? all : where(venue_id: Venue.where(city: city))
  }

  scope :genre, ->(genre) {
    genre.empty? ? all : where(category_id: Category.find_by(description:genre))
  }

  validates_with AttachmentSizeValidator, attributes: :logo, less_than: 1.megabytes
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://static4.businessinsider.com/image/51783cd26bb3f7c826000009/this-is-the-best-way-to-buy-concert-tickets-on-your-iphone.jpg"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  def generate_url
    self.url = "#{date}-#{band.parameterize}"
  end

  def self.active_venues
    relation.where(venue_id: Venue.where(status: 1))
  end
end
