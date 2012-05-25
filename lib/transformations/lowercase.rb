module Protean
  module Transformations
    class Lowercase < Base
      
      # {
      #   "field" => "last_name",
      #   "prep" => "lowercase"
      # }
      def process(shape)
        shape.update_value(shape.value.downcase)
      end

    end
  end
end
