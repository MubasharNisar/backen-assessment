# == Schema Information
#
# Table name: directors
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Director < ApplicationRecord
  has_many :movie_directors
  has_many :movies, through: :movie_directors

  def name
    first_name+" "+last_name
  end
end
