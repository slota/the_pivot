class Order < ActiveRecord::Base
  belongs_to :user
  has_many :concert_orders
  has_many :concerts, through: :concert_orders
end
