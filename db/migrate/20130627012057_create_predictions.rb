class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.integer :station_id
      t.datetime :date
      t.float :level
      t.boolean :high
      t.boolean :low

      t.timestamps
    end


    Prediction.update_predictions(2012)
  end
end
