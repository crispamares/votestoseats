class AddColumnsElection < ActiveRecord::Migration
  def change
    add_column :elections, :country_id, :integer
  end
end
