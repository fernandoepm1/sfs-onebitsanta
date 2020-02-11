class PartyMailer < ApplicationMailer
  def match(party, member, giftee)
    @party  = party
    @member = member
    @giftee = giftee

    mail to: @member.email, subject: "Secret Santa: #{@party.title}"
  end
end
