class AddStdDevToTeamStats < ActiveRecord::Migration
  def change
    add_column :team_stats, :points_planned_std_dev, :decimal
    add_column :team_stats, :points_actual_std_dev, :decimal
    add_column :team_stats, :person_days_planned_std_dev, :decimal
    add_column :team_stats, :person_days_actual_std_dev, :decimal
    add_column :team_stats, :points_per_person_day_planned_std_dev, :decimal
    add_column :team_stats, :points_per_person_day_actual_std_dev, :decimal
    add_column :team_stats, :percent_points_completed_std_dev, :decimal
    add_column :team_stats, :percent_person_days_achieved_std_dev, :decimal
  end
end
