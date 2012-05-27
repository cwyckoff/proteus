module Protean
  module Transformations
    class Prepop < Base

      # {
      #   "trans" => "prepop",
      #   "value" => "ABC123"
      # }

      def process(shape)
        shape.update_value(blueprint["value"])
      end

    end
  end
end
