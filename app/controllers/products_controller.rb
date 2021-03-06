class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @locales = LANGUAGES
    @product = Product.new
  end

  def edit
    @locales = LANGUAGES
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html {
          @locales = LANGUAGES
          render :new
        }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }

        @products = Product.all
        @current_product = @product
        ActionCable.server.broadcast 'products', html: (render_to_string 'store/index', layout: false)
      else
        format.html {
          @locales = LANGUAGES
          render :edit
        }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def who_bought
    @product = Product.find params[:id]
    @latest_order = ((@product.orders.includes :pay_type).order :updated_at).last
    if stale? @latest_order
      respond_to do |format|
        format.atom
        format.html
        format.json { render json: (@product.to_json include: :orders) }
        format.xml { render xml: (@product.to_xml include: :orders) }
      end
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price, :locale)
    end
end
