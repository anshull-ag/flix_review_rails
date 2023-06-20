class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @movies =  Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def new 
    @movie = Movie.new()
  end

  def create
    @movie = Movie.create(movie_params)
    if @movie.save
      redirect_to @movie
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to @movie
    else
      render :edit, status: :unproccessable_entity
    end
  end

  def destroy 
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice]  = "Movie Deleted Successfully...!!"
    redirect_to movies_url, status: :see_other
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :rating, :description, :release_date)
  end 
end
