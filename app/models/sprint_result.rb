class SprintResult < ActiveRecord::Base
  attr_accessible :person_days_actual, :person_days_planned, :points_actual, :points_planned, :sprint_id, :team_id

  validates :person_days_planned, :presence => true
  validates :points_planned, :presence => true
  validates :sprint_id, :presence => true
  validates :team_id, :presence => true

  validates :person_days_actual, :presence => true, 
    :if => :person_days_and_points_actual_present? 
  validates :points_actual, :presence => true,
    :if => :person_days_and_points_actual_present? 

  belongs_to :team
  belongs_to :sprint

  before_save do
    self.points_per_person_day_planned = 
        points_planned.to_f / person_days_planned.to_f

    if !person_days_actual.nil?
      self.points_per_person_day_actual =  
          points_actual.to_f / person_days_actual.to_f
      self.percent_points_completed = 
          (points_actual.to_f / points_planned.to_f) * 100
      self.percent_person_days_achieved = 
          (person_days_actual.to_f / person_days_planned.to_f) * 100
    end

  end
end


def person_days_and_points_actual_present?
  (!person_days_actual.nil? && points_actual.nil?) ||
    (person_days_actual.nil? && !points_actual.nil?)
end

