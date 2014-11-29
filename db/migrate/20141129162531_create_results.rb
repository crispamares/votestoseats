class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :census_id
      t.integer :party_id
      t.integer :votes
      t.integer :seats
    end
  end
end
