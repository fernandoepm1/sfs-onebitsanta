require "rails_helper"

RSpec.describe PartyMailer, type: :mailer do
  describe "#match" do
    before do
      @party  = create(:party)
      @member = create(:member, party: @party)
      @friend = create(:member, party: @party)
      @mailer = PartyMailer.match(@party, @member, @friend)
    end

    it "renders the headers" do
      expect(@mailer.subject).to eq("Secret Santa: #{@party.title}")
      expect(@mailer.to).to eq([@member.email])
      #expect(@mailer.from).to eq(["from@example.com"])
    end

    it "renders the member name in the body" do
      expect(@mailer.body.encoded).to match(@member.name)
    end

    it "renders the party organizer name in the body" do
      expect(@mailer.body.encoded).to match(@party.user.name)
    end

    it "renders the member link to open in the body" do
      expect(@mailer.body.encoded).to match("/members/#{@member.token}/opened")
    end
  end
end
