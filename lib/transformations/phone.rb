module Protean
  module Transformations
    class Phone < Base
      attr_reader :strategies
      
      # {
      #   "prep" => "phone",
      #   "type" => "split",
      #   "target1" => "area_code"
      #   "target2" => "ph_num"
      # }
      def process(shape)
        send(blueprint["type"], shape)
      end

      private

      def bracket(shape)
        shape.value =~ /(\d{3})(\d{3})(\d{4})/
        shape.update_value("(#{$1}) #{$2}-#{$3}")
      end
      
      def split(shape)
        shape.value =~ /1?(\d{3})(\d{7})/
        shape.target[blueprint["target1"]] = $1
        shape.target[blueprint["target2"]] = $2
      end

      def triple(shape)
        shape.value =~ /1?(\d{3})(\d{3})(\d{4})/
        shape.target[blueprint["target1"]] = $1
        shape.target[blueprint["target2"]] = $2
        shape.target[blueprint["target3"]] = $3
      end
      
    end
  end
end
