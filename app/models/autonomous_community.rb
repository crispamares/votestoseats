class AutonomousCommunity < ActiveRecord::Base

	belongs_to :country
	has_many :provinces, dependent: :destroy

end
