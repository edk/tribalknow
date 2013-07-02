require 'spec_helper'

describe "homes/index" do
  before(:each) do
    assign(:homes, [
      stub_model(Home),
      stub_model(Home)
    ])
  end

  it "renders a list of homes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
