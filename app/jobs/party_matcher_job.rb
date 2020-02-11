class PartyMatcherJob < ApplicationJob
  queue_as :emails

  def perform(party)
    match_results = MatchService.call(party)

    party.members.each { |member| member.generate_token }

    match_results.each do |member, giftee|
      PartyMailer.match(party, member, giftee).deliver_now
    end

    party.update(status: :sorted)

    # Ver se precisa tratar quando o match_results == false
    # mandar email pro dono da party?
  end
end
