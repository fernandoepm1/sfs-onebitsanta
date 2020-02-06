require 'spec_helper'

describe RaffleService do
  before(:each) do
    @gathering = create(:gathering, status: :pending)
  end

  describe '#call' do
    context 'when there are more than 2 members' do
      before(:each) do
        create(:member, gathering: @gathering)
        create(:member, gathering: @gathering)
        create(:member, gathering: @gathering)
        @gathering.reload

        @result = RaffleService.new(@gathering).call
      end

      it 'returns a hash as the result' do
        expect(@result.class).to eql(Hash)
      end

      it 'all hash keys are members' do
        expect(@result.keys.sort).to eql(@gathering.members.sort)
      end

      it 'all hash values are members' do
        expect(@result.values.sort).to eql(@gathering.members.sort)
      end

      it 'guarantees a member does not get himself' do
        @result.each do |pair|
          expect(pair.first).not_to eql(pair.last)
        end
      end

      it 'guarantees 2 members dont get each other' do
        pending
      end
    end

    context 'when there are 2 or less members' do
      before(:each) do
        create(:member, gathering: @gathering)
        @gathering.reload

        @result = RaffleService.new(@gathering).call
      end

      it 'raises an error' do
        expect(@result).to be false
      end
    end
  end
end
