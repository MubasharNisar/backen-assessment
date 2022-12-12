# == Schema Information
#
# Table name: movie_filming_locations
#
#  id                  :bigint           not null, primary key
#  movie_id            :bigint           not null
#  filming_location_id :bigint           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class MovieFilmingLocation < ApplicationRecord
  belongs_to :movie
  belongs_to :filming_location
end
