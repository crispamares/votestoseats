class Census < ActiveRecord::Base

	belongs_to :province
	belongs_to :election
	has_many :result, dependent: :destroy

end
