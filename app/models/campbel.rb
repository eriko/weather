class Campbel < ActiveRecord::Base
  attr_accessible :recorded_datetime, :air_temp_c_avg, :air_temp_c_max, :air_temp_c_min,
                  :dew_point_c_max, :dew_point_c_min, :etrs_mm_total, :heat_index_c_max,
                  :heat_index_c_min, :rain_mm_total, :record_num, :timestamp, :wind_chill_c_max,
                  :wind_chill_c_min, :wind_speed_avg, :wind_speed_ms_max



  def Campbel.last_x_hours(hours,last_record)
    Campbel.order("timestamp ASC").where("timestamp >= ? AND timestamp <= ?",last_record.timestamp.ago(hours.hours),last_record.timestamp)
  end


  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

end
