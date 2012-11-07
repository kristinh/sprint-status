require 'spec_helper'

describe "sprint_results/new" do
  before(:each) do
    assign(:sprint_result, stub_model(SprintResult,
      :team_id => 1,
      :sprint_id => 1,
      :points_planned => 1,
      :points_actual => 1,
      :person_days_planned => 1,
      :person_days_actual => 1
    ).as_new_record)
  end

  it "renders new sprint_result form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sprint_results_path, :method => "post" do
      assert_select "input#sprint_result_team_id", :name => "sprint_result[team_id]"
      assert_select "input#sprint_result_sprint_id", :name => "sprint_result[sprint_id]"
      assert_select "input#sprint_result_points_planned", :name => "sprint_result[points_planned]"
      assert_select "input#sprint_result_points_actual", :name => "sprint_result[points_actual]"
      assert_select "input#sprint_result_person_days_planned", :name => "sprint_result[person_days_planned]"
      assert_select "input#sprint_result_person_days_actual", :name => "sprint_result[person_days_actual]"
    end
  end
end
