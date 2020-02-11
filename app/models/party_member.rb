class PartyMember < ApplicationRecord
  belongs_to :party
  belongs_to :member
end
