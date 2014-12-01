class Census < ActiveRecord::Base

	belongs_to :province
	belongs_to :election
	has_many :results, dependent: :destroy

end
