class Country < ActiveRecord::Base

	has_many :autonomous_communities, dependent: :destroy
	has_many :elections, dependent: :destroy
	has_many :parties, dependent: :destroy

end
