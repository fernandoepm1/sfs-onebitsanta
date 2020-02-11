class MatcherService
  def initialize(party)
    @party = party
  end

  def call
    return false if @party.members.count < 3

    results = {}
    members = @party.members
    friends = members
    i = 0

    while(members.count != i)
      member = members[i]
      i += 1

      loop do
        friend = friends.sample

        if friends.count == 1 && friend == member
          results = {}
          members = @party.members
          friends = members
          i = 0
          break
        elsif friend != member && results[friend] != member
          results[member] = friend
          friends -= [friend]
          break
        end
      end
    end

    return results
  end
end
