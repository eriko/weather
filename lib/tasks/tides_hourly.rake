


namespace :import do
  desc "canvas course status check"
  task :tides_hi_low => :environment do
    begin
      update_stations()

      #get updates to old data based on reality
      Prediction.update_predictions(DateTime.now.year-1)
      #get future predictions
      Prediction.update_predictions(DateTime.now.year)

    rescue OpenURI::HTTPError => ex
      results = Airbrake.notify(ex, "action" => "imporrting tides")
      #Toadhopper.new("ec8dad9ae1ccf9b5ca3c74f3f2f6355b", :notify_host => 'http://pink.evergreen.edu/errbit').post!(ex)
      #Toadhopper.new("ec8dad9ae1ccf9b5ca3c74f3f2f6355b",:notify_host => 'http://pink.evergreen.edu/errbit').post!(ex)
      puts "...and the results are #{results}"
    end
  end
end



def update_stations
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

def opener (hash)
  #puts hash.class
  if hash.instance_of?(Hash) || hash.instance_of?(Array)
    hash.each { |inner_hash| opener(inner_hash) }
  else
    #puts "-------------->"
    puts hash
    #puts "<--------------"
  end
end