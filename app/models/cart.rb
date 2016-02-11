class Cart
  attr_reader :contents

  def initialize(raw_data)
    @contents = raw_data || {}
  end

  def cart_concerts
    @contents.map do |concert_id, quantity|
      concert = Concert.find(concert_id)
      subtotal = quantity.to_i * concert.price.to_i
      CartConcert.new(concert, quantity, subtotal)
    end
  end

  def total
    cart_concerts.reduce(0) { |sum, n| sum + n.subtotal.to_i }
  end

  def add_concert(concert_id, quantity)
    contents[concert_id.to_s] = quantity
  end

  def cart_size
    contents.values.inject(0) { |sum, n| sum + n.to_i }
  end

  def clear
    contents = {}
  end

  def remove_concert(concert)
    contents.delete(concert.id.to_s)
  end

end
