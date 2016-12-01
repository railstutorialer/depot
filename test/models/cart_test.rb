require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test 'add two different products to cart' do
    # one = products :one
    # two = products :two
    #
    # cart = Cart.new
    # line_item_1 = cart.add_product one
    # line_item_1.save!
    # line_item_2 = cart.add_product two
    # line_item_2.save!
    #
    # assert_equal 2, cart.line_items.size, 2
    # assert_equal 19.98, cart.total_price
  end

  test 'add two equal products to cart' do
    # one = products :one
    #
    # cart = Cart.new
    # line_item_1 = cart.add_product one
    # line_item_1.save!
    #
    # line_item_2 = cart.add_product one
    # line_item_2.save!
    #
    # assert_equal 1, cart.line_items.size
    # assert_equal 19.98, cart.total_price
  end
end
