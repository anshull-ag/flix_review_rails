class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :movie_find, except:[:index, :new, :create,:upcoming_movies]
  
  def index
    if 
      params[:category].blank?
      @movies =  Movie.all
    else
      @category_id = Category.find_by(name: params[:category]).id
      @movies = Movie.where(category_id: @category_id)
    end
  end

  def show
  end

  def edit
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

  def upcoming_movies
    @movies = Movie.where('released_date > ?', Date.today)
  end

  private

  def movie_find
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:name, :rating, :description, :released_date, :category_id, :main_image)
  end 
end
