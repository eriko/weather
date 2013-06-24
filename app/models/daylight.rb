class Daylight < ActiveRecord::Base
  attr_accessible :start, :stop
  def Daylight.dst?(time = Time.now)
    Daylight.find(:first,:conditions => ["daylights.start < ? AND daylights.stop > ?",time.strftime("%Y-%m-%d 00:00:01 %Z"),time.strftime("%Y-%m-%d 00:00:01 %Z")])
  end
end
