class Province < ActiveRecord::Base

	belongs_to :autonomous_community
	has_many :censuses, dependent: :destroy

end
