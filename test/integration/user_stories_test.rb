require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  fixtures :pay_types

  include ActiveJob::TestHelper

  test "buying a product" do
    start_order_count = Order.count
    ruby_book = products :ruby

    get '/'
    assert_response :success
    assert_select 'h1', 'Your Pragmatic Catalog'

    post '/add_product/' + ruby_book.id.to_s, xhr: true
    assert_response :success

    cart = Cart.find session[:cart_id]
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

    get '/orders/new'
    assert_response :success
    assert_select 'legend', 'Please Enter Your Details'

    pay_type = pay_types :check

    perform_enqueued_jobs do

      post '/orders', params: {
        order: {
          name: 'Dave Thomas',
          address: '123 The Street',
          email: 'railstutorial15@gmail.com',
          pay_type_id: pay_type.id
        }
      }
      follow_redirect!

      assert_response :success
      assert_select 'h1', 'Your Pragmatic Catalog'
      cart = Cart.find session[:cart_id]
      assert_equal 0, cart.line_items.size

      assert_equal start_order_count + 1, Order.count
      order = Order.last
      assert_equal 'Dave Thomas', order.name
      assert_equal '123 The Street', order.address
      assert_equal 'railstutorial15@gmail.com', order.email
      assert_equal 'check', order.pay_type.label

      assert_equal 1, order.line_items.size
      line_item = order.line_items[0]
      assert_equal ruby_book, line_item.product

      mail = ActionMailer::Base.deliveries.last
      assert_equal ['railstutorial15@gmail.com'], mail.to
      assert_equal 'Rails Tutorial15 <railstutorial15@gmail.com>', mail[:from].value
      assert_equal 'Pragmatic Store Order Confirmation', mail.subject

    end
  end

  test 'changing ship date' do

    order = orders :one

    get '/order_management'
    assert_response :success

    order_id = order.id.to_s

    get '/order_management/show_change_ship_date/' + order_id
    assert_response :success

    patch '/order_management/change_ship_date/' + order_id, params: {
      order: {
        ship_date: '2016-12-01'
      }
    }
    follow_redirect!
    assert_response :success

    order = (Order.find order_id)
    ship_date = Date.new 2016, 12, 1
    assert_equal ship_date, order.ship_date
  end

  test 'throw error' do
    perform_enqueued_jobs do
      non_existing_id = -1
      begin
        get '/order_management/show_change_ship_date/' + non_existing_id.to_s
      rescue
        mail = ActionMailer::Base.deliveries.last
        assert_equal mail.subject, 'An error occurred!'
      end
    end
  end

end
