class SprintResult < ActiveRecord::Base
  attr_accessible :person_days_actual, :person_days_planned, :points_actual, :points_planned, :sprint_id, :team_id
end
