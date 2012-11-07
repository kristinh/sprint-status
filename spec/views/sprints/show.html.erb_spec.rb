require 'spec_helper'

describe "sprints/show" do
  before(:each) do
    @sprint = assign(:sprint, stub_model(Sprint,
      :name => "Name",
      :work_days => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
  end
end
