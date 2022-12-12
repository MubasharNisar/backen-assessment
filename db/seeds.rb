# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'
require 'pry'


def load_and_parse_file(filename)
  file = File.read(Rails.root.join(filename))
  return CSV.parse(file, :headers => true, :encoding => 'ISO-8859-1')
end

def split_into_first_name_and_last_name( full_name )
  name_array = full_name.split(' ') 
  
  if name_array.count > 1                   
    last_name  = name_array.pop    
    first_name = name_array.join(' ') 

  else                                      
    first_name = name_array.first           
    last_name  = nil
  end

  return [ first_name, last_name ]
end

def name(first_name, last_name)
  return first_name+" "+last_name
end

def create_actor_record(movie_id, row_hash)
  movie = Movie.find(movie_id)
  movie_actors = movie.actors.map{|act| self.name(act.first_name, act.last_name) == row_hash["Actor"] ? true : false}
  prev_exist = Actor.all.map{|act| self.name(act.first_name, act.last_name) == row_hash["Actor"] ? act : nil}.compact
  if !movie_actors.include?(true) and prev_exist.empty?
    actor_name = self.split_into_first_name_and_last_name(row_hash["Actor"])
    actor = Actor.create(first_name: actor_name[0], last_name: actor_name[1])
    MovieActor.create(actor_id: actor.id, movie_id: movie_id)
  elsif !movie_actors.include?(true) and prev_exist.present?
    MovieActor.create(actor_id: prev_exist.first.id, movie_id: movie_id)
  end
end

def create_director_record(movie_id, row_hash)
  movie = Movie.find(movie_id)
  movie_directors = movie.directors.map{|dir| self.name(dir.first_name, dir.last_name) == row_hash["Director"] ? true : false}
  prev_dict = Director.all.map{|dir| self.name(dir.first_name, dir.last_name) == row_hash["Director"] ? dir : nil}.compact
  if !movie_directors.include?(true) and prev_dict.empty?
    dir_name = self.split_into_first_name_and_last_name(row_hash["Director"])
    director = Director.create(first_name: dir_name[0], last_name: dir_name[1])
    MovieDirector.create(director_id: director.id, movie_id: movie_id)
  elsif !movie_directors.include?(true) and prev_dict.present?
    MovieDirector.create(director_id: prev_dict.first.id, movie_id: movie_id)
  end
end

def create_country_record(movie_id, row_hash)
  movie = Movie.find(movie_id)
  movie_countries = movie.countries.map{|cont| cont.name == row_hash["Country"] ? true : false}
  prev_exist = Country.all.map{|cont| cont.name == row_hash["Country"] ? cont : nil}.compact
  if !movie_countries.include?(true) and prev_exist.empty?
    country = Country.create(name: row_hash["Country"])
    MovieCountry.create(country_id: country.id, movie_id: movie_id)
  elsif !movie_countries.include?(true) and prev_exist.present?
    MovieCountry.create(country_id: prev_exist.first.id, movie_id: movie_id)
  end
end

def create_location_record(movie_id, row_hash)
  movie = Movie.find(movie_id)
  movie_locations = movie.filming_locations.map{|loc| loc.name == row_hash["Filming location"] ? true : false}
  prev_exist = FilmingLocation.all.map{|loc| loc.name == row_hash["Filming location"] ? loc : nil}.compact
  if !movie_locations.include?(true) and prev_exist.empty?
    location = FilmingLocation.create(name: row_hash["Filming location"])
    MovieFilmingLocation.create(filming_location_id: location.id, movie_id: movie_id)
  elsif !movie_locations.include?(true) and prev_exist.present?
    MovieFilmingLocation.create(filming_location_id: prev_exist.first.id, movie_id: movie_id)
  end
end

def create_review_record(movie_id, user_id, row_hash)
  Review.create(movie_id: movie_id, user_id: user_id, comment: row_hash["Review"], rating: row_hash["Stars"])
end

movies_data = self.load_and_parse_file('movies.csv')

movies_data.each do |row|
  row_hash = row.to_hash
  movie_title = row_hash["Movie"]
  movie = Movie.where(title: movie_title).present? ? Movie.where(title: movie_title).first : Movie.create(
    title: movie_title, description: row_hash["Description"], year: row_hash["Year"])
  self.create_actor_record(movie.id, row_hash)
  self.create_director_record(movie.id, row_hash)
  self.create_country_record(movie.id, row_hash)
  self.create_location_record(movie.id, row_hash)
end


reviews_data = self.load_and_parse_file('reviews.csv')

reviews_data.each do |row|
  row_hash = row.to_hash
  movie_title = row_hash["Movie"]
  movie = Movie.where(title: movie_title).first
  if movie
    user = User.all.map{|user| self.name(user.first_name, user.last_name) == row_hash["User"] ? user : nil}.compact
    if user.empty?
      user_name = self.split_into_first_name_and_last_name(row_hash["User"])
      user = User.create(first_name: user_name[0], last_name: user_name[1])
      self.create_review_record(movie.id, user.id, row_hash)
    else
      self.create_review_record(movie.id, user.first.id, row_hash) if !Review.where(
        user_id: user.first.id, movie_id: movie.id).present?
    end
  end
end

