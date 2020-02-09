class Member < ApplicationRecord
	has_many :gathering_members
	has_many :gatherings, through: :gathering_members

	attr_default :saw_mail, false
	attr_default :is_user, false

	validates :name, :email, :gatherings

	before_create :generate_token
	after_save :update_gathering

	private

	def generate_token
		token =
			loop do
				random_token = SecureRandom.urlsafe_base64(nil, false)
				break random_token unless Member.exists?(token: random_token)
			end
			save!
	end

	def update_gathering
		gathering.update(status: :pending)
	end
end
