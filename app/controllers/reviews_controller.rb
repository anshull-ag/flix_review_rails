class ReviewsController < ApplicationController
  before_action :set_movie
  before_action :set_review, only: [:edit, :show, :update, :destroy]
  before_action :has_reviewed, only: :new
  
  def index
    @reviews = @movie.reviews.all
  end

  def show
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
      flash[:error] = @review.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
  end

  def update 
    if @review.update(review_params)
      flash[:notice] = "Review successfully updated!"
      redirect_to   movie_reviews_path(@movie,@review)
    else
      flash[:error] = @review.errors.full_messages.join(',')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    flash[:notice]  = "Review Deleted Successfully...!!"
    redirect_to movie_reviews_url, status: :see_other
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_review
    @review = @movie.reviews.find(params[:id])
  end

  def has_reviewed
    if Review.where(user_id: current_user.id, movie_id: @movie.id).any?
      review = Review.where(user_id: current_user.id, movie_id: @movie.id)
      redirect_to movie_review_url(@movie.id,review.first.id)
      flash[:notice] = "You've already written a review for this movie."
    end
  end

  def review_params
    params.require(:review).permit(:body,:star,:movie_id,:user_id)
  end
end
