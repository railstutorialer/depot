class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart

  skip_before_action :authorize

  def index
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
    @counter = session[:counter]

    @products = Product.order :title
    @can_checkout = true
  end
end
