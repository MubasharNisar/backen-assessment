# == Schema Information
#
# Table name: filming_locations
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class FilmingLocation < ApplicationRecord
  has_many :movie_filming_locations
  has_many :movies, through: :movie_filming_locations
end
