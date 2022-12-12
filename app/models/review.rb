# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  comment    :text
#  rating     :integer
#  movie_id   :bigint           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  after_create :update_movie_rating

  private 

  def update_movie_rating
    new_rating = self.movie.reviews.map{|rev| rev.rating}.sum
    self.movie.update_column(:rating, new_rating.to_f/5)
  end 
end
