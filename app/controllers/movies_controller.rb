class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :movie_find, except:[:index, :new, :create,:upcoming_movies,:recent_movies]
  
  def index
    if params[:filter]
      @movies = set_movie
    elsif params[:category]
      category_id = Category.find_by(name: params[:category]).id
      @movies = Movie.where(category_id: category_id)
    else
      @movies =  Movie.all
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

  private

  def set_movie
    if params[:filter] == 'upcoming_movies'
      @movies = Movie.where('released_date > ?', Date.today).order(released_date:'asc')
    elsif params[:filter] == 'popular'
      @movies = Movie.joins(:reviews).group('movies.id').having('AVG(reviews.star) > ?',3.5)
    elsif params[:filter] == 'recent_movies'
      @movies = Movie.where('released_date < ?', Date.today).order('released_date desc').limit(6)
    end
    
  end

  def movie_find
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:name, :rating, :description, :released_date, :category_id,:star_cast, :main_image)
  end 
end
