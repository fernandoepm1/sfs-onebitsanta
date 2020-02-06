require "rails_helper"

RSpec.describe GatheringMailer, type: :mailer do
  describe "raffle" do
    before do
      @gathering = create(:gathering)
      @member    = create(:member, gathering: @gathering)
      @friend    = create(:member, gathering: @gathering)
      @mailer    = GatheringMailer.raffle(@gathering, @member, @friend)
    end

    it "renders the headers" do
      expect(@mailer.subject).to eq("Secret Santa: #{@gathering.title}")
      expect(@mailer.to).to eq([@member.email])
      #expect(@mailer.from).to eq(["from@example.com"])
    end

    it "renders the member name in the body" do
      expect(@mailer.body.encoded).to match(@member.name)
    end

    it "renders the gathering organizer name in the body" do
      expect(@mailer.body.encoded).to match(@gathering.user.name)
    end

    it "renders the member link to open in the body" do
      expect(@mailer.body.encoded).to match("/members/#{@member.token}/opened")
    end
  end
end
