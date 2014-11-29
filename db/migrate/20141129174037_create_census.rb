class CreateCensus < ActiveRecord::Migration
  def change
    create_table :censuses do |t|
      t.integer :election_id
      t.integer :provice_id
      t.integer :population
      t.integer :number_of_tables
      t.integer :electoral_census
      t.integer :electoral_census_without_cera
      t.integer :electoral_census_cera
      t.integer :electoral_census_total
      t.integer :applications_for_cera_accepted
      t.integer :total_cer_voters
      t.integer :total_cera_voters
      t.integer :total_voters
      t.integer :valid_votes
      t.integer :votes_for_parties
      t.integer :votes_blank
      t.integer :votes_null
      t.integer :seats
    end
  end
end
