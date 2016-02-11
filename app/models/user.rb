class User < ActiveRecord::Base
  has_secure_password
  has_many :venue_users
  has_many :managed_venues, through: :venue_users,
                    class_name: "Venue",
                    foreign_key: "venue_id",
                    source: :venue
  has_many :orders
  has_many :orders
  has_many :venues

  validates :username, presence: true,
                     uniqueness: true

  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://i.telegraph.co.uk/multimedia/archive/02067/bowie_2067738b.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

   enum role: %w(registered_user business_admin platform_admin)
end
