require 'spec_helper'

describe "teams/index" do
  before(:each) do
    assign(:teams, [
      stub_model(Team,
        :name => "Name",
        :product_owner => "Product Owner"
      ),
      stub_model(Team,
        :name => "Name",
        :product_owner => "Product Owner"
      )
    ])
  end

  it "renders a list of teams" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Product Owner".to_s, :count => 2
  end
end
