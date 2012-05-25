module Protean
  module Transformations
    class Uppercase < Base
      
      # {
      #   "field" => "last_name",
      #   "prep" => "uppercase"
      # }
      def process(shape)
        shape.update_value(shape.value.upcase)
      end

    end
  end
end
