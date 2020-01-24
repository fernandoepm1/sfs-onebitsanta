class GatheringMember < ApplicationRecord
  belongs_to :gathering
  belongs_to :member
end
