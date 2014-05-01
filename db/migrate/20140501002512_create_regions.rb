class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.text :long_lat_corner_pairs, :null => false
      t.geometry :bounding_box, :srid => 4326, :null => false

      t.timestamps
    end
  end
end
