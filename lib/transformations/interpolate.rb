module Preppers
  
  class Interpolate < Prepper

    # {
    #   "prep" => "interpolate",
    #   "target" => "name",
    #   "format" => "[last_name] - [first_name]"
    # }
    def process(shape)
      shape.target[blueprint['target']] = interpolate(shape)
    end

    private
    
    def interpolate(shape)
      blueprint["format"].gsub(/\[([\w\d]+)\]/) do |match|
        key = match.gsub("[", "").gsub("]", "")
        shape.original[key] 
      end
    end

  end

end
