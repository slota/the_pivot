class Concert < ActiveRecord::Base
  belongs_to :venue
  before_validation :generate_url
  has_many :concert_orders
  has_many :orders, through: :concert_orders
  belongs_to :category

  scope :band, ->(params) {
    band = params[:search][:Band]
    where("band LIKE '%#{band}%'")
  }
  scope :date, ->(params) {
    text_date = params[:search][:Date]
      where(date: Date.strptime(text_date, "%Y-%m-%d")) unless text_date.empty?
    # if !text_date.empty?
    #   date = Date.strptime(text_date, "%Y-%m-%d")
    #   where(date: date)
    # end
  }
  scope :city, ->(params) {
    city = params[:search][:City]
    where(venue_id: Venue.find_by(city: city))
  }
  scope :genre, ->(params) {
    genre = params[:search][:Genre]
    where(category_id: Category.find_by(description: genre))
  }

  validates_with AttachmentSizeValidator, attributes: :logo, less_than: 1.megabytes
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://static4.businessinsider.com/image/51783cd26bb3f7c826000009/this-is-the-best-way-to-buy-concert-tickets-on-your-iphone.jpg"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  def generate_url
    self.url = "#{date}-#{band.parameterize}"
  end



  def self.filter_band(params)
    band = params
    # band = params[:search][:Band]
    if band
      relation.where("band LIKE '%#{band}%'")
    else
      relation
    end
  end

  def self.filter_date(params)
    text_date = params[:search][:Date]
    date = Date.strptime(text_date, "%Y-%m-%d")
    if date
      # relation.where("date LIKE '%#{date}%'")
      relation.where(date: date)
      # binding.pry
    else
      relation
    end
  end

  def self.filter_city(params)
    city = params[:search][:City]
    if city == 99
      relation.where("band LIKE '%#{city}%'")
    else
      relation
    end
  end

  def self.active_venues
    relation.where(venue_id: Venue.where(status: 1))
  end

end
