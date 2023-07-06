class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_movie, only: [:show, :update, :destroy]

  load_and_authorize_resource
 
  def index
    if params[:filter]
      @movies = filter
    elsif params[:category]
      category_id = Category.find_by(name: params[:category]).id
      @movies = Movie.where(category_id: category_id)
    else
      @movies =  Movie.all
    end
  end
  
  def show
  end

  def new 
    if current_user.role == 'admin'
      @movie = Movie.new
    end
  end

  def create
    @movie = Movie.create(movie_params)
    if @movie.save
      redirect_to @movie
    else
      flash[:error] = @movie.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie
    else
      flash[:error] = @review.errors.full_messages.join(', ')
      render :edit, status: :unproccessable_entity
    end
  end

  def destroy 
    @movie.destroy
    flash[:notice]  = "Movie Deleted Successfully!"
    redirect_to movies_url, status: :see_other
  end

  
  
  private

  def filter
    if params[:filter] == 'upcoming_movies'
      @movies = Movie.where('released_date > ?', Date.today).order(released_date:'asc')
    elsif params[:filter] == 'popular'
      @movies = Movie.joins(:reviews).group('movies.id').having('AVG(reviews.star) > ?',3.5)
    elsif params[:filter] == 'recent_movies'
      @movies = Movie.where('released_date < ?', Date.today).order('released_date desc').limit(6)
    end
  end
  
  def search
    byebug
    movie = params[:search]
    @search = Movie.where('name LIKE ?', "%#{movie}%")
                     
    if @search.present?
      render 'search'
    else
      flash.now[:alert] = 'No movies found matching the search criteria.'
      render 'search'
    end
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:name, :rating, :description, :released_date, :category_id,:star_cast, :main_image)
  end 
end
