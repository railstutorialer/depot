class CartsController < ApplicationController
  skip_before_action :authorize

  def destroy
    cart_manager = CartManager.new session[:cart_id]
    id = params[:id].to_i
    result = cart_manager.destroy id

    if result[:change][:action] == :destroy
      session.delete :cart_id
    end

    respond_to do |format|
      format.js do
        if result[:change][:action] == :destroy
          @cart = result[:cart]
          render 'destroy'
        else
          error = result[:error]
          if error[:code] == :not_found
            status_code = 404
          elsif error[:code] == :db_error
            status_code = 500
          end

          render :status => status_code
        end
      end
    end
  end

end
