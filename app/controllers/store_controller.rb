class StoreController < ApplicationController
  skip_before_action :authorize

  include CurrentCart
  before_action :set_cart

  def index
    if params[:set_locale]
      redirect_to (store_index_url locale: params[:set_locale])
    end

    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
    @counter = session[:counter]

    i18n_manager = I18nManager.new

    @products = (Product.where :locale => i18n_manager.get_locale).order :title
    @can_checkout = true
  end
end
