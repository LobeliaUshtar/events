class User < ActiveRecord::Base
	has_many :registrations, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :liked_events, through: :likes, source: :event
	
	has_secure_password
	
	validates :name, presence: true
	
	validates :email, presence: true, format: /\A\S+@\S+\z/, uniqueness: { case_sensitive: false }

	validates :password, length: { minimum: 5, allow_blank: true }

	scope :by_name, -> { order(:name) }
	scope :not_admins, -> { by_name.where(admin: false) }

	def self.authenticate(email, password)
		user = User.find_by(email: email)
		user && user.authenticate(password)
	end
end