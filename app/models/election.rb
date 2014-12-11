class Election < ActiveRecord::Base

	has_many :results, dependent: :destroy
	has_many :censuses, dependent: :destroy

	#Election.results_for(1977, "Almería")
	def self.results_for(year, province_name)
		election = Election.where('extract(year  from election_day) = ?', year).first
		province = Province.find_by_name(province_name)

		census = Census.where(election_id: election.id, province_id: province.id).select(:id, :population).first
		election_results = census.results.joins(:party).where("votes > 0").order("votes desc").pluck("parties.name", "parties.acronym", :votes, :seats)

		results_json = {
			province_name: province.name,
			census: census,
			results: election_results
		}.to_json
	end

end
