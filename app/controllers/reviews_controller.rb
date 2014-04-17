class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @product = Product.find(params[:product_id])
    @reviews  = @product.reviews
  end

  def new
    @product = Product.find(params[:product_id])
    @review  = Review.new
  end

  def create
    @product = Product.find(params[:product_id])
    @review  = @product.reviews.build(review_params)
    @review.product_id = @product.id
    @review.author_id  = current_user.id
    if @review.save
      flash[:notice] = "You're review has been successfully added."
      redirect_to product_reviews_path(@product)
    else
      flash[:notice] = "Please fill in the required fields."
      render :new
    end
  end

  protected

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
