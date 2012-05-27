module Protean
  module Transformations
    class Lowercase < Base

      # {
      #   "trans" => "lowercase"
      # }

      def process(shape)
        shape.update_value(shape.value.downcase)
      end

    end
  end
end
