#**********************************************************************
# Shape class encapsulates the changing shape of the Field.
# It also preserves the original source, but that is immutable
# Shape objects assume that current shape (i.e., the 'target' hash)
# should only contain one key/value pair.
#**********************************************************************
module Protean
  class Field
    class Shape
      attr_accessor :target
      attr_reader :source, :original_key

      def initialize(field_name, source)
        @original_key, @source, @target = field_name, source, {}
      end

      def current
        (target.empty?) ? source : target
      end

      def value
        current[key]
      end

      def key
        (target.empty?) ? original_key : target.flatten.first
      end

      def original
        source
      end

      def update_value(v)
        target[key] = v
      end

      def override_source(new_source)
        @source = new_source
      end
    end
  end
end
