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
require "test_helper"

class MovieCountryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
