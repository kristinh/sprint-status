# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121108132441) do

  create_table "sprint_results", :force => true do |t|
    t.integer  "team_id"
    t.integer  "sprint_id"
    t.integer  "points_planned"
    t.integer  "points_actual"
    t.integer  "person_days_planned"
    t.integer  "person_days_actual"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.decimal  "points_per_person_day_planned"
    t.decimal  "points_per_person_day_actual"
    t.decimal  "percent_points_completed"
    t.decimal  "percent_person_days_achieved"
  end

  create_table "sprints", :force => true do |t|
    t.string   "name"
    t.date     "start"
    t.date     "end"
    t.integer  "work_days"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "product_owner"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
