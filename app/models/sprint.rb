class Sprint < ActiveRecord::Base
  attr_accessible :end, :name, :start, :work_days
  has_many :sprint_results
end
