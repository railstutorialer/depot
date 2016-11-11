class CartManager

  def initialize id
    @id = id
  end

  def add_product product_id

    if @id
      @cart = Cart.find @id
      if @cart
        current_item = @cart.line_items.find_by product_id: product_id
        product = Product.find product_id
        if current_item
          current_item.quantity += 1
          current_item.total_price += product.price
          result = current_item.save

          if result
            action = :increment
          else
            action = :none
          end
        elsif product
          current_item = @cart.line_items.build product_id: product_id, total_price: product.price
          result = current_item.save
          action = :create_line_item
        else
          result = false

          action = :none
        end
      else
        result = false
        action = :none
      end
    else
      product = Product.find product_id
      if product
        @cart = Cart.new
        current_item = @cart.line_items.build product_id: product_id, total_price: product.price, quantity: 1
        result = @cart.save
        if result
          result = current_item.save
          if result
            action = :create
          else
            @cart = nil
            result = false
            action = :none
          end
        else
          @cart = nil
          result = false
          action = :none
        end
      else
        @cart = nil
        result = false
        action = :none
      end
    end

    change = {}
    change[:line_item] = current_item
    change[:action] = action
    result = {}
    result[:cart] = @cart
    result[:result] = result
    result[:change] = change

    result
  end

  def destroy_line_item line_item_id
    if @id
      @cart = Cart.find @id
      if @cart
        current_item = @cart.line_items.find line_item_id
        if current_item
          success = current_item.destroy
          if success
            if @cart.empty?
              result = @cart.destroy
              if result
                @cart = nil
                action = :destroy
              else
                action = :none
              end
            else
              action = :destroy_line_item
            end
          else
            action = :none
          end
        else
          success = false
          action = :none
        end
      else
        success = false
        action = :none
      end
    else
      @cart = nil
      success = false
      action = :none
    end

    result = {}
    result[:cart] = @cart
    result[:success] = success
    change = {}
    change[:action] = action
    change[:line_item] = current_item
    result[:change] = change

    result
  end

  def decrement line_item_id

    if @id
      @cart = Cart.find @id

      if @cart
        current_item = @cart.line_items.find line_item_id

        if current_item
          if current_item.quantity == 1
            success = current_item.destroy
            if success
              Rails::logger.debug 'destroy'
              Rails::logger.debug @cart.empty?
              if @cart.empty?
                success = @cart.destroy
                if success
                  action = :destroy
                else
                  action = :none
                  error_code = :db_error
                end
              end
            else
              action = :none
              error_code = :db_error
            end
          else
            current_item.quantity -= 1
            current_item.total_price -= current_item.product.price
            success = current_item.save
            action = :decrement
          end
        else
          success = false
          action = :none
          error_code = :not_found
        end
      else
        success = false
        action = :none
        error_code = :not_found
      end
    else
      success = false
      error_code = :not_found
      action = :none
    end

    result = {}
    result[:cart] = @cart
    result[:success] = success
    change = {}
    change[:line_item] = current_item
    change[:action] = action
    result[:change] = change
    error = {}
    error[:code] = error_code
    result[:error] = error_code

    result
  end

  def destroy id
    if @id && @id == id
      @cart = Cart.find id
      if @cart
        success = @cart.destroy
        if success
          @cart = nil
          action = :destroy
        else
          success = false
          action = :none
        end
      else
        success = false
        action = :none
      end
    else
      success = false
      action = :none
    end

    result = {}
    result[:cart] = @cart
    result[:success] = success
    change = {}
    change[:action] = action
    result[:change] = change

    result
  end
end
