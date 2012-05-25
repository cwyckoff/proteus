module Protean

  class ProteusImmutableSourceError < Exception; end

  class Field
    attr_reader :name, :target, :transformations, :source

    def initialize(field)
      @name, @transformations = field
    end

    def transform(source)
      @source = source
      shape = new_shape(source)

      begin
        process_subs(shape)
        transformations.each { |t| Transformations.instance_for(name, t).process(shape) }
      rescue RuntimeError => e
        raise ProteusImmutableSourceError if e.message =~ /frozen/
        raise e
      end
      shape.current
    end

    def new_shape(source)
      Shape.new(name, source)
    end

    def process_subs(shape)

      if subs = get_subs
        p = Proteus.new(subs)
        new_source = source.dup
        shape.override_source(new_source.merge(p.process(source)))
      end
    end

    def get_subs
      subs = transformations.select {|t| t.keys.include?("sub_trans")}.first.try(:[],"sub_trans")
      transformations.delete_if {|t| t.keys.include?("sub_trans")}
      subs
    end

    ##########################
    # Shape class encapsulates the changing shape of the Field.
    # It also preserves the original source, but that is immutable
    # Shape objects assume that current shape (i.e., the 'target' hash)
    # should only contain one key/value pair.
    ##########################
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
