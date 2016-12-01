class OrderManagementController < ApplicationController


  # include HandleGlobalError

  #rescue_from ActiveRecord::RecordNotFound, with: :handle_error

  def index
    @orders = Order.all
  end

  def show_change_ship_date
    Order.find params[:id]
    order_manager = OrderManager.new params[:id]
    @order = order_manager.get
  end

  def change_ship_date
    order_manager = OrderManager.new params[:id]
    order_manager.add_ship_date_listener do |order|
      (OrderMailer.ship_date_changed order).deliver_later
    end
    ship_date = params[:order][:ship_date]
    order_manager.change_ship_date ship_date
    redirect_to action: 'index'
  end

  def ship
    order_manager = OrderManager.new params[:id]
    order_manager.add_shipping_listener do |order|
      logger.debug 'order controller'
      (OrderMailer.shipped order).deliver_later
    end

    order_manager.ship
    redirect_to action: 'index'
  end

  def handle_error e
    ErrorMailer.global_error e
  end
end
