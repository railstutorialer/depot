require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:one)
    get store_index_url
  end
   
  # test "should create line_item via ajax" do
  #   assert_difference 'LineItem.count' do
  #     post (add_product_line_item_url product_id: (products :ruby).id), xhr: true
  #   end
  #
  #   assert_response :success
  #   assert_select_jquery :html, '#cart' do
  #     assert_select 'tr#current_item td', /Programming Ruby 1.9/
  #   end
  # end
  #
  # test "should decrement line_item via ajax" do
  #
  # end
  #
  # test "should destroy line_item via ajax" do
  #   assert_difference('LineItem.count', -1) do
  #     delete line_item_url(@line_item)
  #   end
  #
  #   assert_redirected_to line_items_url
  # end
end
