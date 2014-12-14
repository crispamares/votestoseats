class Election < ActiveRecord::Base

	has_many :results, dependent: :destroy
	has_many :censuses, dependent: :destroy

	#Election.results_for(1977, 4)
	def self.results_for(year, province)
		election = Election.where('extract(year  from election_day) = ?', year).first
		province = Province.find(province)

		census = Census.where(election_id: election.id, province_id: province.id).select(:id, :population, :electoral_census_total, :votes_blank, :votes_null, :total_voters).first
		election_results = census.results.joins(:party).where("votes > 0").order("votes desc").pluck("parties.name", "parties.acronym", :votes, :seats)

		total_seats = 0
		election_results.each do |result|
			total_seats += result[3]
		end

		results_json = {
			province_name: province.name,
			province_id: province.id,
			year: year,
			population: census.population,
			electoral_census: census.electoral_census_total,
			province_seats: total_seats,
			votes_blank: census.votes_blank,
			votes_null: census.votes_null,
			total_voters: census.total_voters,
			results: election_results
		}
	end

end
