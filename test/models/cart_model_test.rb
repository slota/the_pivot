require 'test_helper'

class CartModelTest < ActionDispatch::IntegrationTest
  test 'initialize' do
    assert Cart.new('test')
  end

  test 'clear' do
    cart = Cart.new('test')
    cart.clear
    assert cart.contents.empty?
  end
end
