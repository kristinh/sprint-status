class Team < ActiveRecord::Base
  attr_accessible :name, :product_owner
  has_many :sprint_results
  has_one  :team_stats
end
