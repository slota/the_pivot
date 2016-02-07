class Venue < ActiveRecord::Base
  has_many :concerts
  belongs_to :user
  enum status: %w(Pending Approved Declined)

  validates :name, presence: true
  validates :url, presence: true, uniqueness: true

  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://static4.businessinsider.com/image/51783cd26bb3f7c826000009/this-is-the-best-way-to-buy-concert-tickets-on-your-iphone.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  before_validation :generate_url

  def generate_url
    self.url = name.parameterize
  end

end
