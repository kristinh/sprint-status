class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.string :name
      t.date :start
      t.date :end
      t.integer :work_days

      t.timestamps
    end
  end
end
