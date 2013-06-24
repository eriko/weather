class Davi < ActiveRecord::Base
  attr_accessible :bp, :dp, :hot, :hws, :ih, :it, :lot, :oh, :ot, :r, :recorded_datetime, :wc, :wd, :ws
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end
end
