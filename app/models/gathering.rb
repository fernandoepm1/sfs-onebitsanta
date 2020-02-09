class Gathering < ApplicationRecord
  belongs_to :user

  has_many :gathering_members
  has_many :members, through: :gathering_members

  attr_default :status, :pending

  validates :title, :description, :user, :status, presence: true

  enum status: [:pending, :finished]

  before_create :set_member

  private

  def set_member
    members.create(name: user.name, email: user.email, is_user: true)
  end
end
