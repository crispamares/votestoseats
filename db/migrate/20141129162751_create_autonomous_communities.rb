class CreateAutonomousCommunities < ActiveRecord::Migration
  def change
    create_table :autonomous_communities do |t|
      t.string :name
      t.integer :country_id
    end
  end
end
