class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :product_owner

      t.timestamps
    end
  end
end
