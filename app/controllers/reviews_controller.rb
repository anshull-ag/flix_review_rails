class ReviewsController < ApplicationController

  def index
    @movie = Movie.find(params[:movie_id])
    @reviews = @movie.reviews.all
  end

  def new 
    @movie = Movie.find(params[:movie_id])
    @review = Review.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.new(review_params)
    @review.user = current_user 
    if @review.save
      redirect_to movie_reviews_path
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:body,:star,:movie_id,:user_id)
  end
end
