class AddStatsToSprintResult < ActiveRecord::Migration
  def change
    add_column :sprint_results, :points_per_person_day_planned, :decimal
    add_column :sprint_results, :points_per_person_day_actual, :decimal
    add_column :sprint_results, :percent_points_completed, :decimal
    add_column :sprint_results, :percent_person_days_achieved, :decimal
  end
end
