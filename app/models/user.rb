class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :venues

  validates :username, presence: true,
                     uniqueness: true

   enum role: %w(registered_user business_admin platform_admin)
end
