require 'rails_helper'

RSpec.describe SiteStat, type: :model do
  context "empty recent activity" do
    before do
      expect(SiteStat).to receive_message_chain(:where, :last).and_return([])
    end

    it "returns none" do
      expect(SiteStat.recent_activity).to be_empty
    end
  end

  # context "some recent activity" do
  #   let(:tenant) { FactoryBot.create(:tenant) }
  #   before do
  #     Tenant.current_id = tenant.id
  #   end
  #   after do
  #     Tenant.current_id = nil
  #   end
  #   it "generates a new cached record" do
  #     SiteStat.generate_recent_activity!
  #   end
  #   it "returns the latest cached record"
  # end

  context "cleanup" do
    it "removes old cached activity"
  end

end
