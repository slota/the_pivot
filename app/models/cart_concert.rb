class CartConcert < SimpleDelegator
  attr_reader :concert, :quantity, :subtotal

  def initialize(concert, quantity, subtotal)
    super(concert)
    @quantity = quantity
    @subtotal = subtotal
  end
end