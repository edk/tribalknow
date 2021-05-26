require 'rails_helper'

RSpec.describe ContentFixup, type: :model do
  it "applies with no records" do
    expect(ContentFixup.count).to be_zero
    ContentFixup.apply(text: "")
  end

  let(:cf1) {
    ContentFixup.create(text: txt)
  }

  it "replaces one domain with another" do
    cf1
  end
end
