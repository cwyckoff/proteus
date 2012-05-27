module Protean
  module Transformations
    class Truncate < Base

      # {
      #   "trans" => "truncate"
      #   "limit" => 5,
      # }

      def process(shape)
        shape.update_value(truncate_field(shape))
      end

      private

      def truncate_field(shape)
        return "" if shape.value.blank?

        shape.value.to_s[0..(blueprint["limit"].to_i - 1)]
      end
    end
  end
end
