# == Schema Information
#
# Table name: movie_actors
#
#  id         :bigint           not null, primary key
#  movie_id   :bigint           not null
#  actor_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class MovieActor < ApplicationRecord
  belongs_to :movie
  belongs_to :actor
end
