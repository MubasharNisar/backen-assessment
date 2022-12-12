# == Schema Information
#
# Table name: movie_directors
#
#  id          :bigint           not null, primary key
#  movie_id    :bigint           not null
#  director_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class MovieDirector < ApplicationRecord
  belongs_to :movie
  belongs_to :director
end
