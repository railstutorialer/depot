class OrderManager

  def initialize id
    @id = id
    @shipping_listeners = []
    @ship_date_listeners = []
  end

  def add_shipping_listener &block
    @shipping_listeners << block
  end

  def add_ship_date_listener &block
    @ship_date_listeners << block
  end

  def get
    order
  end

  def change_ship_date ship_date
    order.update :ship_date => ship_date
    @ship_date_listeners.each do |ship_date_listener|
      ship_date_listener.call order
    end
  end

  def ship
    @shipping_listeners.each do |shipping_listener|
      shipping_listener.call order
    end
  end

  def order
    @order ||= Order.find @id
  end

end
