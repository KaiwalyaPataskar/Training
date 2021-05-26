class MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :edit, :update, :get_rating]

  def index
    @movies = Movie.all.as_json
  end

  def show
    respond_to do |format|
      format.html
      format.xml { render xml: @movie.as_json }
      format.json { render json: @movie }
    end
  end

  def new
    Movie.new
  end

  def edit
    render json: @movie
  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json: movie
    else
      movie.errors
    end
  end

  def update
    if @movie.update(movie_params)
      render json: @movie
    else
      render json: movie.errors
    end
  end

  def get_rating
    render json: @movie.rating
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :rating)
  end

  def find_movie
    @movie = Movie.find_by(id: params[:id])
    @movie.present? ? @movie : (render json: 'Invalid record')
  end
end
