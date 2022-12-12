class MoviesController < ApplicationController
  def index
    @movies = Movie.all.order("movies.rating desc")
  end

  def search
    actors = Actor.search(params[:actor])
    @movies = actors.map{|act| act.movies}.flatten.sort_by{ |obj| obj.rating }.reverse
  end
end
