class CreateTeamStats < ActiveRecord::Migration
  def change
    create_table :team_stats do |t|
      t.integer :team_id
      t.decimal :points_planned_mean
      t.decimal :points_actual_mean
      t.decimal :person_days_planned_mean
      t.decimal :person_days_actual_mean
      t.decimal :points_per_person_day_planned_mean
      t.decimal :points_per_person_day_actual_mean
      t.decimal :percent_points_completed_mean
      t.decimal :percent_person_days_achieved_mean

      t.timestamps
    end
  end
end
