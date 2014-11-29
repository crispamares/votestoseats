class CreateElections < ActiveRecord::Migration
  def change
    create_table :elections do |t|
      t.string :name
      t.string :type
      t.datetime :election_day
    end
  end
end
