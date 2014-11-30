namespace :import_csv do

  desc "Import CSV from infoelectoral.interior.es as records"

  task spanish_congress: :environment do
    puts "Parsing...."

    file = "db/data/spanish_congress/2011/PROV_02_201111_1.csv"
    #file = "db/data/spanish_congress/1977/PROV_02_197706_1.csv"
    rows = CSV.read(file, { :col_sep => ";" })

    rows.each_with_index do |row, index|

      if index == 3 then
        #Parse all parties
        puts "parsing parties"

        for i in 16..row.length-1
          if i.even? then
            puts row[i]
          end
        end
      end

      if index > 5 && index < 58 then
        #puts "current_index: #{index}"
        #puts "#{index} current province: #{row[2]}"
        #puts row[15]
        #votes for first party
        #puts row[16]
        #puts row[0]
      end
    end

  end

end
