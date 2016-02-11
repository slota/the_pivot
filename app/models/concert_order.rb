class ConcertOrder < ActiveRecord::Base
  belongs_to :concert
  belongs_to :order
  belongs_to :venue

  def self.create_concert_order(order, cart)
    cart.contents.each do |concert_id, quantity|
      concert_price = Concert.find_by(id: concert_id).price
      subtotal = concert_price * quantity.to_i
      ConcertOrder.create(order_id: order.id,
                          concert_id: concert_id,
                          quantity: quantity.to_i,
                          subtotal: subtotal)
    end
  end
end
