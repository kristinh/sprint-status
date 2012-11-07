require 'spec_helper'

describe "sprint_results/show" do
  before(:each) do
    @sprint_result = assign(:sprint_result, stub_model(SprintResult,
      :team_id => 1,
      :sprint_id => 2,
      :points_planned => 3,
      :points_actual => 4,
      :person_days_planned => 5,
      :person_days_actual => 6
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
  end
end
