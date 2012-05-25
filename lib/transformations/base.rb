module Protean
  module Transformations
    class Base
      attr_reader :blueprint

      def initialize(blueprint)
        @blueprint = blueprint
      end

      def source_field
        blueprint["field"]
      end
    end
  end
end
