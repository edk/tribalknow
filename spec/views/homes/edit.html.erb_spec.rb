require 'spec_helper'

describe "homes/edit" do
  before(:each) do
    @home = assign(:home, stub_model(Home))
  end

  it "renders the edit home form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", home_path(@home), "post" do
    end
  end
end
