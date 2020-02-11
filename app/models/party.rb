class Party < ApplicationRecord
  belongs_to :user

  has_many :party_members
  has_many :members, through: :party_members

  validates :title, :description, :user, :status, presence: true

  enum status: [:pending, :finished]

  after_create :set_member

  private

  def set_member
    members.create(name: user.name, email: user.email, is_user: true)
  end
end
