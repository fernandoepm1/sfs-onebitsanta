class RaffleService
  def initialize(gathering)
    @gathering = gathering
  end

  def call
    return false if @gathering.members.count < 3

    results = {}
    members = @gathering.members
    friends = members
    i = 0

    while(members.count != i)
      member = members[i]
      i += 1

      loop do
        friend = friends.sample

        if friends.count == 1 && friend == member
          results = {}
          members = @gathering.members
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
