# == Schema Information
#
# Table name: movie_countries
#
#  id         :bigint           not null, primary key
#  movie_id   :bigint           not null
#  country_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class MovieCountry < ApplicationRecord
  belongs_to :movie
  belongs_to :country
end
