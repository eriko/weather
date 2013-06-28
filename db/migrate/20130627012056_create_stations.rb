class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.string :longname
      t.string :url
      t.text :description
      t.integer :parent_id
      t.float :height_low
      t.float :height_high
      t.float :time_low
      t.float :time_high

      t.timestamps
    end

    seattle = Station.find_or_initialize_by_name name: "9447130", longname: "SEATTLE, WA",
                                                 height_low: 0, height_high: 0,
                                                 time_low: 0, time_high: 0
    seattle.save

    rocky = Station.find_or_initialize_by_name name: "TWC1115", longname: "Rocky Point, Eld Inlet",
                                               height_low: 1.10, height_high: 1.31,
                                               time_low: 56, time_high: 39,
                                               parent_id: seattle.id
    rocky.save

    oly = Station.find_or_initialize_by_name name: "9446969", longname: "Olympia, Budd Inlet, WA",
                                             height_low: 1.08, height_high: 1.29,
                                             time_low: 57, time_high: 45,
                                             parent_id: seattle.id
    oly.save
  end
end
