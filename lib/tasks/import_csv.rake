namespace :import_csv do

  desc "Import CSV from infoelectoral.interior.es as records"

  task spanish_congress: :environment do
    puts "Opening CSV from infoelectoral.interior.es"

    #file = "db/data/spanish_congress/1986/PROV_02_198606_1.csv"
    #file = "db/data/spanish_congress/1989/PROV_02_198910_1.csv"
    file = "db/data/spanish_congress/2011/PROV_02_201111_1.csv"


    rows = CSV.read(file, { :col_sep => ";" })

    election_day = Time.new(2011, 11, 20)
    election = Election.find_or_create_by(election_day: election_day, country_id: 1)
    election.update_attributes(name: "Congreso | Noviembre 2011", :chamber => "Congreso")

    rows.each_with_index do |row, index|

      #parse Parties
      if index == 3 then
        puts "parsing parties --->"
        for i in 16..row.length-1
          if i.even? then
            puts row[i]
            puts rows[4][i]
            party = Party.find_or_create_by(name: row[i])
            party.update_attributes( :acronym => rows[4][i], :country_id => 1, :foundation => election_day)
          end
        end
      end

      #parse Provinces
      if index > 5 && index < 58 then
        puts "parsing province ---> #{row[2]}"
        autonomous_community = AutonomousCommunity.find_or_create_by(name: rows[index][0].rstrip)
        autonomous_community.update_attributes(:country_id => 1)

        province = Province.find_or_create_by(province_code: rows[index][1])
        province.update_attributes(name: rows[index][2].rstrip, :autonomous_community_id => autonomous_community.id)

        census = Census.find_or_create_by(election_id: election.id, province_id: province.id)
        census.update_attributes(
          population: rows[index][3].delete('.').to_i,
          number_of_tables: rows[index][4].delete('.').to_i,
          electoral_census_without_cera: rows[index][5].delete('.').to_i,
          electoral_census_cera: rows[index][6].delete('.').to_i,
          electoral_census_total: rows[index][7].delete('.').to_i,
          applications_for_cera_accepted: rows[index][8].delete('.').to_i,
          total_cer_voters: rows[index][9].delete('.').to_i,
          total_cera_voters: rows[index][10].delete('.').to_i,
          total_voters: rows[index][11].delete('.').to_i,
          valid_votes: rows[index][12].delete('.').to_i,
          votes_for_parties: rows[index][13].delete('.').to_i,
          votes_blank: rows[index][14].delete('.').to_i,
          votes_null:rows[index][15].delete('.').to_i
        )

        #results for Parties
        for j in 16..row.length-1
          if j.even? then
            current_party = Party.find_by(name: rows[3][j])
            result = Result.find_or_create_by(census_id: census.id, party_id: current_party.id)
            result.update_attributes( votes: rows[index][j].delete('.').to_i, seats: rows[index][j+1].delete('.').to_i)
          end
        end

      end
    end

  end

  task spanish_congress_recent: :environment do
    puts "Opening CSV from infoelectoral.interior.es"

    file = "db/data/spanish_congress/1986/PROV_02_198606_1.csv"
    #file = "db/data/spanish_congress/1989/PROV_02_198910_1.csv"
    #file = "db/data/spanish_congress/1989/PROV_02_198910_1.csv"


    rows = CSV.read(file, { :col_sep => ";" })

    election_day = Time.new(1986, 06, 22)
    election = Election.find_or_create_by(election_day: election_day, country_id: 1)
    election.update_attributes(name: "Congreso | Junio 1986", :chamber => "Congreso")

    rows.each_with_index do |row, index|

      #parse Parties
      if index == 3 then
        puts "parsing parties --->"
        for i in 15..row.length-1
          if !i.even? then
            puts row[i]
            puts rows[4][i]
            party = Party.find_or_create_by(name: row[i])
            party.update_attributes( :acronym => rows[4][i], :country_id => 1, :foundation => election_day)
          end
        end
      end

      #parse Provinces
      if index > 5 && index < 58 then
        puts "parsing province ---> #{row[2]}"
        autonomous_community = AutonomousCommunity.find_or_create_by(name: rows[index][0].rstrip)
        autonomous_community.update_attributes(:country_id => 1)

        province = Province.find_or_create_by(province_code: rows[index][1])
        province.update_attributes(name: rows[index][2].rstrip, :autonomous_community_id => autonomous_community.id)

        census = Census.find_or_create_by(election_id: election.id, province_id: province.id)
        census.update_attributes(
        population: rows[index][3].delete('.').to_i,
        number_of_tables: rows[index][4].delete('.').to_i,
        electoral_census_without_cera: rows[index][5].delete('.').to_i,
        electoral_census_cera: rows[index][6].delete('.').to_i,
        electoral_census_total: rows[index][7].delete('.').to_i,
        #applications_for_cera_accepted: rows[index][8].delete('.').to_i,
        total_cer_voters: rows[index][8].delete('.').to_i,
        total_cera_voters: rows[index][9].delete('.').to_i,
        total_voters: rows[index][10].delete('.').to_i,
        valid_votes: rows[index][11].delete('.').to_i,
        votes_for_parties: rows[index][12].delete('.').to_i,
        votes_blank: rows[index][13].delete('.').to_i,
        votes_null:rows[index][14].delete('.').to_i
        )

        #results for Parties
        for j in 15..row.length-1
          if !j.even? then
            current_party = Party.find_by(name: rows[3][j])
            result = Result.find_or_create_by(census_id: census.id, party_id: current_party.id)
            result.update_attributes( votes: rows[index][j].delete('.').to_i, seats: rows[index][j+1].delete('.').to_i)
          end
        end

      end
    end

  end

  task spanish_congress_old: :environment do
    puts "Opening CSV from infoelectoral.interior.es old results"

    file = "db/data/spanish_congress/1982/PROV_02_198210_1.csv"

    rows = CSV.read(file, { :col_sep => ";" })

    election_day = Time.new(1982, 10, 28)
    election = Election.find_or_create_by(election_day: election_day, country_id: 1)
    election.update_attributes(name: "Congreso | Octubre 1982", :chamber => "Congreso")

    rows.each_with_index do |row, index|

      #parse Parties
      if index == 3 then
        puts "parsing parties --->"
        for i in 11..row.length-1
          if !i.even? then
            #puts row
            #puts row[i]
            puts rows[3][i]
            puts rows[4][i]
            party = Party.find_or_create_by(name: rows[3][i])
            party.update_attributes( :acronym => rows[4][i], :country_id => 1, :foundation => election_day)
          end
        end
      end

      #parse Provinces
      if index > 5 && index < 58 then
        puts "parsing province ---> #{row[2]}"
        autonomous_community = AutonomousCommunity.find_or_create_by(name: rows[index][0].rstrip)
        autonomous_community.update_attributes(:country_id => 1)

        province = Province.find_or_create_by(province_code: rows[index][1])
        province.update_attributes(name: rows[index][2].rstrip, :autonomous_community_id => autonomous_community.id)

        census = Census.find_or_create_by(election_id: election.id, province_id: province.id)
        census.update_attributes(
        population: rows[index][3].delete('.').to_i,
        number_of_tables: rows[index][4].delete('.').to_i,
        electoral_census_total: rows[index][5].delete('.').to_i,
        total_voters: rows[index][6].delete('.').to_i,
        valid_votes: rows[index][7].delete('.').to_i,
        votes_for_parties: rows[index][8].delete('.').to_i,
        votes_blank: rows[index][9].delete('.').to_i,
        votes_null:rows[index][10].delete('.').to_i
        )

        #results for Parties
        for j in 11..row.length-1
          if !j.even? then
            current_party = Party.find_by(name: rows[3][j])
            result = Result.find_or_create_by(census_id: census.id, party_id: current_party.id)
            result.update_attributes( votes: rows[index][j].delete('.').to_i, seats: rows[index][j+1].delete('.').to_i)
          end
        end

      end
    end

  end

end
