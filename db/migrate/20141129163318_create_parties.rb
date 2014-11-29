class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :name
      t.string :acronym
      t.integer :country_id
      t.datetime :foundation
      t.string :color
    end
  end
end
