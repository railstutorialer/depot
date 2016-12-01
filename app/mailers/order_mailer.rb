class OrderMailer < ApplicationMailer
  default from: 'Rails Tutorial15 <railstutorial15@gmail.com>'


  def received order
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
  end

  def shipped order
    @order = order
    logger.debug 'order mail'
    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end

  def ship_date_changed order
    @order = order
    mail to: order.email, subject: 'Shipping date changed'
  end
end
