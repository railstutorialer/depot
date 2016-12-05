class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create, :destroy]
  before_action :ensure_cart_isnt_empty, only: :new
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:new, :create]

  def new
    @order = Order.new
    @pay_types = (PayType.includes [:name_translation => :translation_records]).all.collect { |t| [t.name, t.id] }
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart @cart

    respond_to do |format|
      if @order.save
        Cart.destroy session[:cart_id]
        session[:cart_id] = nil
        (OrderMailer.received @order).deliver_later
        format.html { redirect_to store_index_url, notice: (I18n.t '.thanks')}
        format.json { render :show, status: :created, location: @order }
      else
        format.html do
          @pay_types = PayType.all.collect { |t| [t.label, t.id] }
          render :new
        end
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type_id)
    end

    def ensure_cart_isnt_empty
      if @cart.empty?
        redirect_to store_index_url, notice: 'Your cart is empty.'
      end
    end
end
