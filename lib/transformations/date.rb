module Preppers

  class Date < Prepper

    # {
    #   "key" => "timestamp",
    #   "map" => "date",
    #   "format" => "%Y/%m/%d",
    # }
    def process(shape)
      time = shape.value
      return time if time.blank?
      
      time = Time.parse(time)

      if blueprint["method"]
        time = time.utc.send(blueprint["method"])
      else 
        time = time.strftime(blueprint["format"])
      end

      shape.update_value(time)
    end

  end
end
