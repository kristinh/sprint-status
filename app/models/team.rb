class Team < ActiveRecord::Base
  attr_accessible :name, :product_owner
  has_many :sprint_results
  has_one  :team_stats

  before_create :set_team_stats
end

def set_team_stats
  self.build_team_stats
end
