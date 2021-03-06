module Protean
  module Transformations
    class Concatenate < Base

      # {
      #   "trans" => "concatenate",
      #   "separator" => ", ",
      #   "format" => "last_name, first_name",
      # }
      def process(shape)
        # shape.target[shape.key] = concatenate(shape)
        shape.update_value(concatenate(shape))
      end

      private

      def concatenate(shape)
        separator = blueprint['separator'] ? blueprint['separator'] : ", "
        blueprint['format'].split(",").map{|key| shape.original[key.strip]}.join(separator)
      end

    end

  end
end
