# == Schema Information
#
# Table name: actors
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Actor < ApplicationRecord
  include SearchCop

  search_scope :search do
    attributes :first_name, :last_name
  end
  
  has_many :movie_actors
  has_many :movies, through: :movie_actors

  def name
    first_name+" "+last_name
  end
end
