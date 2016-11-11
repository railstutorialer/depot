class CartsController < ApplicationController
  # before_action :set_cart, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    cart_manager = CartManager.new session[:cart_id]
    id = params[:id].to_i
    result = cart_manager.destroy id



    if result[:change][:action] == :destroy
      session.delete :cart_id
    end

    respond_to do |format|
      format.js do
        @cart = result[:cart]
      end
      format.html { redirect_to store_index_url }
      format.json { head :no_content }
    end
  end
end
