module Protean

  class ProteusImmutableSourceError < Exception; end

  class Field
    attr_reader :name, :target, :transformations

    def initialize(transformations)
      @name, @transformations = transformations
    end

    def transform(source)
      shape = new_shape(source)
      begin
        transformations.each { |t| Transformations.instance_for(name, t).process(shape) }
      rescue RuntimeError => e
        raise ProteusImmutableSourceError if e.message =~ /frozen/
        raise e
      end
      shape.current
    end

    def new_shape(source)
      @shape ||= Shape.new(name, source)
    end

    ##########################
    # Shape class encapsulates the changing shape of the Field.
    # It also preserves the original source, but that is immutable
    # Shape objects assume that current shape (i.e., the 'target' hash)
    # should only contain one key/value pair.
    ##########################
    class Shape
      attr_reader :source, :target, :original_key

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
      
    end
  end
end
