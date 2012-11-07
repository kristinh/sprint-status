class Team < ActiveRecord::Base
  attr_accessible :name, :product_owner
  has_many :sprint_results
end
