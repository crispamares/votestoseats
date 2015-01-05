class Election < ActiveRecord::Base

	has_many :censuses, dependent: :destroy

	#Election.results_for(2011)
	def self.results(year)
		election = Election.where('extract(year  from election_day) = ?', year).first
		table_of_results = []
		total_seats = 350
		population = 0
		electoral_census_total = 0
		total_voters = 0
		votes_blank = 0
		votes_null = 0

		#Aggregate results
		election.censuses.each do |census|
			population += census[:population]
			electoral_census_total += census[:electoral_census_total]
			total_voters += census[:total_voters]
			votes_blank += census[:votes_blank]
			votes_null += census[:votes_null]

			census.results.each do |result|
				current_party_index = table_of_results.index{|party| party[:party_id] == result[:party_id] }
				if current_party_index.nil?
					table_of_results.push({party_id: result[:party_id], seats: result[:seats], votes: result[:votes]})
				else
					table_of_results[current_party_index][:seats] += result[:seats]
					table_of_results[current_party_index][:votes] += result[:votes]
				end
			end
		end

		#Order by seats obtained
		table_of_results = table_of_results.sort_by{ |r| r[:seats]}
		table_of_results.reverse!

		#Calculate percentages %votes %seats %cost of votes per seat and get names
		table_of_results.each do |party|
			p = Party.find(party[:party_id])
			party[:name] = p.name
			party[:acronym] = p.acronym
			party[:percent_votes] = (party[:votes].to_f*100/(total_voters-votes_null) * 100/100).round(2)
			party[:percent_seats] = (party[:seats].to_f*100/total_seats * 100/100).round(2)
			party[:votes_per_seats] = (party[:votes]/party[:seats].to_f).round(2)
		end

		results_json = {
			election_type: "Congreso de los Diputados",
			country: "Spain",
			year: year,
			total_seats: total_seats,
			population: population,
			electoral_census_total: electoral_census_total,
			total_voters: total_voters,
			votes_blank: votes_blank,
			votes_null: votes_null,
			general_results: table_of_results
		}

	end

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
