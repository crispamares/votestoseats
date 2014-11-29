class Election < ActiveRecord::Base

	has_many :results, dependent: :destroy
	has_many :censuses, dependent: :destroy

end
