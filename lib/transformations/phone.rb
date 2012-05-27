module Protean
  module Transformations
    class Phone < Base
      attr_reader :strategies

      # {
      #   "trans" => "phone",
      #   "type" => "formatted",
      # }

      # {
      #   "trans" => "phone",
      #   "type" => "area_code",
      # }

      # {
      #   "trans" => "phone",
      #   "type" => "prefix",
      # }

      # {
      #   "trans" => "phone",
      #   "type" => "line_number",
      # }

      def process(shape)
        send(blueprint["type"], shape)
      end

      private

      def formatted(shape)
        shape.value =~ /(\d{3})(\d{3})(\d{4})/
        shape.update_value("(#{$1}) #{$2}-#{$3}")
      end

      def area_code(shape)
        shape.value =~ /1?(\d{3})\d{3}\d{4}/
        shape.update_value($1)
      end

      def prefix(shape)
        shape.value =~ /1?\d{3}(\d{3})\d{4}/
        shape.update_value($1)
      end

      def line_number(shape)
        shape.value =~ /1?\d{3}\d{3}(\d{4})/
        shape.update_value($1)
      end
    end
  end
end
