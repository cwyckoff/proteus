module Protean
  module Transformations
    class Remove < Base

      # {
      #   "trans" => "remove",
      #   "conditional" => "blank?"
      # }

      def process(shape)
        shape.target = {} if shape.value.send(blueprint["conditional"])
      end

    end
  end
end
