module Protean
  module Transformations
    class Blank < Base

      # {
      #   "trans" => "blank",
      #   "field" => "source_id",
      # }
      def process(shape)
        shape.update_value("")
      end

    end
  end
end
