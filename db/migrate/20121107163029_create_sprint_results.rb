class CreateSprintResults < ActiveRecord::Migration
  def change
    create_table :sprint_results do |t|
      t.integer :team_id
      t.integer :sprint_id
      t.integer :points_planned
      t.integer :points_actual
      t.integer :person_days_planned
      t.integer :person_days_actual

      t.timestamps
    end
  end
end
