class ReviewsController < ApplicationController
  before_action :movie_setup
  before_action :has_reviewed, only: :new
  
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

  def show
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
    @review = @movie.reviews.find(params[:id])
    @review.destroy
    flash[:notice]  = "Review Deleted Successfully...!!"
    redirect_to movie_reviews_url, status: :see_other
 end

  private

  def movie_setup
    @movie = Movie.find(params[:movie_id])
  end

  def has_reviewed
    if Review.where(user_id: current_user.id, movie_id: @movie.id).any?
      redirect_to movie_reviews_url(@movie.id)
      flash[:notice] = "You've already written a review for this movie."
    end
  end

  def review_params
    params.require(:review).permit(:body,:star,:movie_id,:user_id)
  end
end
