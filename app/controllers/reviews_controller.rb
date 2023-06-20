class ReviewsController < ApplicationController
  before_action :movie_setup

  def index
    @reviews = @movie.reviews.all
  end

  def new 
    @review = Review.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user 
    if @review.save
      redirect_to movie_reviews_path
    else
      render :new
    end
  end

  def edit
    @review = @movie.reviews.find(params[:id])
  end

  def update 
    @review = @movie.reviews.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = "Review successfully updated!"
    redirect_to   movie_reviews_path(@movie,@review)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    flash[:notice]  = "Review Deleted Successfully...!!"
    redirect_to movie_reviews_url, status: :see_other
 end

  private

  def movie_setup
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:body,:star,:movie_id,:user_id)
  end
end
