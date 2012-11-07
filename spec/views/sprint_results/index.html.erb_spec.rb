require 'spec_helper'

describe "sprint_results/index" do
  before(:each) do
    assign(:sprint_results, [
      stub_model(SprintResult,
        :team_id => 1,
        :sprint_id => 2,
        :points_planned => 3,
        :points_actual => 4,
        :person_days_planned => 5,
        :person_days_actual => 6
      ),
      stub_model(SprintResult,
        :team_id => 1,
        :sprint_id => 2,
        :points_planned => 3,
        :points_actual => 4,
        :person_days_planned => 5,
        :person_days_actual => 6
      )
    ])
  end

  it "renders a list of sprint_results" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
  end
end
