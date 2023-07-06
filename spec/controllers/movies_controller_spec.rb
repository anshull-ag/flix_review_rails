require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns all movies to @movies' do
      movie1 = create(:movie)
      movie2 = create(:movie)
      
      get :index
      expect(assigns(:movies)).to match_array([movie1, movie2])
    end

    context 'with filter parameter' do
      it 'returns upcoming movies' do
        upcoming_movie = create(:movie, released_date: Date.tomorrow)
        create(:movie, released_date: Date.yesterday)
        
        get :index, params: { filter: 'upcoming_movies' }
        expect(assigns(:movies)).to match_array([upcoming_movie])
      end

      it 'returns popular movies' do
        popular_movie = create(:movie)
        create(:review, movie: popular_movie, star: 4)
        
        get :index, params: { filter: 'popular' }
        expect(assigns(:movies)).to match_array([popular_movie])
      end

      it 'returns recent movies' do
        recent_movie1 = create(:movie, released_date: Date.yesterday)
        create(:movie, released_date: Date.today)
        
        get :index, params: { filter: 'recent_movies' }
        expect(assigns(:movies)).to match_array([recent_movie1])
      end
    end

    context 'with category parameter' do
      it 'returns movies for the specified category' do
        category = create(:category)
        movie1 = create(:movie, category: category)
        movie2 = create(:movie)
        
        get :index, params: { category: category.name }
        expect(assigns(:movies)).to match_array([movie1])
      end
    end
  end
end
