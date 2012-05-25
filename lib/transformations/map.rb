module Protean
  module Transformations
    class Map < Base

      def process(shape)
        current_key = shape.key
        shape.target[blueprint["target"]] = shape.value
        shape.target.delete(current_key)
      end

    end
  end
end
