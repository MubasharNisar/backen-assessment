# == Schema Information
#
# Table name: movies
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  year        :string
#  rating      :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Movie < ApplicationRecord
  has_many :movie_actors
  has_many :actors, through: :movie_actors
  has_many :movie_directors
  has_many :directors, through: :movie_directors
  has_many :movie_countries
  has_many :countries, through: :movie_countries
  has_many :movie_filming_locations
  has_many :filming_locations, through: :movie_filming_locations
  has_many :reviews
  has_many :users, through: :reviews
end
