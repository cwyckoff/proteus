module Protean
  module Transformations
    class ValueMap < Base

      # {
      #   "trans" => "value_map"
      #   "mappings" => {
      #     "old_value" => "new_value"
      #   },
      #   "default" => "some_value"
      # }

      def process(shape)
        val = blueprint["mappings"][shape.value] || val = blueprint["default"]
        shape.update_value(val) if val
      end
    end
  end
end
