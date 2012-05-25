module Protean
  module Transformations
    class Map < Base

      def process(shape)
        shape.target[blueprint["target"]] = shape.value
      end

    end
  end
end
