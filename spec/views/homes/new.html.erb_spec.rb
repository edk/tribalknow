require 'spec_helper'

describe "homes/new" do
  before(:each) do
    assign(:home, stub_model(Home).as_new_record)
  end

  it "renders new home form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", homes_path, "post" do
    end
  end
end
