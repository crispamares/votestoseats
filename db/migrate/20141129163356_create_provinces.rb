class CreateProvinces < ActiveRecord::Migration
  def change
    create_table :provinces do |t|
      t.string :name
      t.integer :province_code
      t.integer :autonomous_community_id
    end
  end
end
