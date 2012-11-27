class TeamStats < ActiveRecord::Base
  attr_accessible :percent_person_days_achieved_mean, :percent_points_completed_mean, :person_days_actual_mean, :person_days_planned_mean, :points_actual_mean, :points_per_person_day_actual_mean, :points_per_person_day_planned_mean, :points_planned_mean, :team_id

  belongs_to :team

  def self.dimensions
    [:last_3, :last_5, :all]
  end

end
