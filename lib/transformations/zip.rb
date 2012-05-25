module Protean
  module Transformations
    class Zip < Prepper

      # {
      #   "prep" => "zip",
      #   "field" => "postal_code",
      #   "target1" => "zip",
      #   "target2" => plus4"
      # }
      def process(shape)
        shape.value =~ /^(\d{5})-?(\d{4})?$/
        shape.target[blueprint["target1"]] = $1
        shape.target[blueprint["target2"]] = $2
      end
    end

  end
end
