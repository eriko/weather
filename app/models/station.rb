class Station < ActiveRecord::Base
  attr_accessible :description, :height_high, :height_low, :longname, :name, :parent_id, :time_high, :time_low, :url  ,:parent
  belongs_to :station,class_name: "Station"
  has_many :station, class_name: "Substation",foreign_key: :parent_id

  has_many :predictions

  def adjustments(kind)
    case kind
      when "H"
        return [self.height_high,self.time_high]
      when "L"
        return [self.height_low,self.time_low]
      else
        return nil
    end
  end
end
