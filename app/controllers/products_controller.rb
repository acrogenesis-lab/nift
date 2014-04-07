class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @products = Product.limit(20)
  end

  def new
    @product = Product.new
    @product.company = Company.new
  end

  def create
    @company = Company.find_or_create_by(product_params[:company_attributes])
    @product = Product.new(product_params)
    @product.company = @company
    @product.user = current_user

    if @product.save
      redirect_to root_path, notice: "You just created a new Product"
    else
      render :new
    end
  end

  def search
    @products = Product.search("%#{query_params}%")
  end

  private

  def query_params
    params.require(:query)
  end

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :price,
      :url,
      company_attributes: [:name, :location, :url]
      )
  end
end