class Prediction < ActiveRecord::Base
  attr_accessible :date, :high, :level, :low, :station_id
  belongs_to :station

  def Prediction.update_predictions(year)
    client = Savon.client(wsdl: "http://opendap.co-ops.nos.noaa.gov/axis/webservices/highlowtidepred/wsdl/HighLowTidePred.wsdl")

    message = {stationId: "9447130",
               beginDate: "#{year.to_s}1001 00:00",
               endDate: "#{(year+1).to_s}0930 23:59",
               datum: "MLLW",
               unit: "1",
               timeZone: "0"
    }


    response = client.call(:get_hl_pred_and_metadata, message: message)
    stations = Station.all
    response.hash[:envelope][:body][:high_low_values][:high_low_values][:item].each do |data|
      date = data[:@date]
      if date
        data[:data].each do |pred|
          stations.each do |station|
            height_adj, time_adj = station.adjustments(pred[:type])
            time_string = "#{date} #{pred[:time]}"
            #puts time_string
            new_time = DateTime.strptime(time_string, "%m/%d/%Y %H:%M")+time_adj #apply station specific time adjustment
            #puts new_time
            prediction = Prediction.where(station_id: station.id, date: new_time).first
            unless prediction
              prediction = Prediction.new(station_id: station.id, date: new_time, level: (pred[:pred].to_i + height_adj*0.3048), high: pred[:type].eql?("H"), low: pred[:type].eql?("L"))
              prediction.save
            end
          end
        end
      end
    end
  end

  end
