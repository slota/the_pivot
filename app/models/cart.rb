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

  def subtract_concert(concert_id)
    contents[concert_id.to_s] ||= 0
    contents[concert_id.to_s] -= 1
    if contents[concert_id.to_s] == 0
      contents.delete(concert_id.to_s)
    end
    Concert.find(concert_id)
  end

  def cart_size
    @contents.values.sum
  end

  def count_of(cart_id)
    contents[cart_id.to_s]
  end

  def clear
    @contents = {}
  end

  def add_or_subtract_concert(action, concert)
    if action == "add"
      add_concert(concert.id)
    else
      subtract_concert(concert.id)
    end
  end

  def remove_concert_completely(concert_id)
    contents.delete(concert_id.to_s)
  end

  def remove_notice?(action)
    action == "subtract"
  end

end
