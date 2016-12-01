require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart = carts(:one)
  end

  test "should destroy cart" do
    post add_product_line_item_url product_id: (products :ruby).id, xhr: true
    @cart = Cart.find session[:cart_id]

    assert_difference('Cart.count', -1) do
      delete cart_url(@cart), xhr: true
    end

    assert_response :success
    assert_select_jquery :html, '#cart' do
      assert_select 'tr:not(.total_line)', false
    end
  end
end
