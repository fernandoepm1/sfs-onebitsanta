class GatheringMailer < ApplicationMailer
  def raffle(gathering, member, friend)
    @gathering = gathering
    @member    = member
    @friend    = friend

    mail to: @member.email, subject: "Secret Santa: #{@gathering.title}"
  end
end
