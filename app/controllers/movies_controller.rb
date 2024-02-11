class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
    @movie = Movie.new
    @movie.title = params.fetch("query_title")
    @movie.year = params.fetch("query_year")
    @movie.duration = params.fetch("query_duration")
    @movie.description = params.fetch("query_description")
    @movie.image = params.fetch("query_image")
    @movie.director_id = params.fetch("query_director_id")

    if @movie.valid?
      @movie.save
      redirect_to("/movies", { :notice => "Movie created successfully." })
    else
    redirect_to("/movies", { :notice => "Movie created unsuccessfully." })
    end
  end

  def update
    path_id = params.fetch("path_id")
    @movie = Movie.where({ :id => path_id}).at(0)

    @movie.title = params.fetch("query_title")
    @movie.year = params.fetch("query_year")
    @movie.duration = params.fetch("query_duration")
    @movie.description = params.fetch("query_description")
    @movie.image = params.fetch("query_image")
    @movie.director_id = params.fetch("query_director_id")

    if @movie.valid?
      redirect_to("/movies/#{@movie.id}", { :notice => "Movie updated successfully" })
    else
      redirect_to("/movies/#{@movie.id}", { :notice => "Movie updated unsuccessfully" })
    end
  end

  def destroy
    path_id = params.fetch("path_id")
    @movie = Movie.where({ :id => path_id }).at(0)
    @movie.destroy
    redirect_to("/movies", { :notice => "Movie deleted successfully" })
  end
  
end
