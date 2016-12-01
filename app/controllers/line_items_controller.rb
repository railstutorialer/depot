class LineItemsController < ApplicationController

  skip_before_action :authorize, only: [:add_product, :destroy, :decrement]

  def add_product

    session.delete :counter

    cart_manager = CartManager.new session[:cart_id]
    product_id = params[:product_id].to_i
    result = cart_manager.add_product product_id

    logger.debug result[:change][:action]

    if result[:change][:action] = :create
      cart = result[:cart]
      session[:cart_id] = cart.id
    end


    respond_to do |format|
      format.js do
        action = result[:change][:action]
        if action != :none
          @cart = result[:cart]
          @current_item = result[:change][:line_item]
          if action == :create
            render 'carts/create'
          elsif action == :create_line_item
            render 'create'
          elsif action == :increment
            render 'increment'
          end
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
      format.html do
        @cart = result[:cart]
        @current_item = result[:change][:line_item]
        redirect_to store_index_path
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    cart_manager = CartManager.new session[:cart_id]
    id = params[:id].to_i
    result = cart_manager.destroy_line_item id

    if result[:change][:action] == :destroy
      session.delete :cart_id
    end

    respond_to do |format|
      format.js do
        @cart = result[:cart]
        action = result[:change][:action]
        if action != :none
          if action == :destroy
            render 'carts/destroy'
          elsif action == :destroy_line_item
            render 'destroy'
          end
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

  def decrement
    cart_manager = CartManager.new session[:cart_id]
    id = params[:id].to_i
    result = cart_manager.decrement id

    if result[:change][:action] == :destroy
      session.delete :cart_id
    end

    respond_to do |format|
      format.js do
        @cart = result[:cart]
        action = result[:change][:action]

        if action != :none
          if action == :destroy
            render 'carts/destroy'
          else
            if action == :destroy_line_item
              render 'destroy'
            elsif action == :decrement
              render 'decrement'
            end
          end
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
