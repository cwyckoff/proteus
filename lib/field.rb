module Protean
  class ImmutableSourceError < Exception; end

  class Field
    attr_reader :name, :target, :source, :transformations

    def initialize(field)
      @name, _ = field
      @transformations = Transformations::Collection.new(field)
    end

    def transform(source)
      @source = source
      shape = Shape.new(name, source)

      begin
        process_children(shape)
        transformations.each { |t| t.process(shape) }
      rescue RuntimeError => e
        raise ImmutableSourceError if e.message =~ /frozen/
        raise e
      end
      shape.target
    end

    def process_children(shape)
      if transformations.have_children?
        p = Proteus.new(transformations.children)
        new_source = source.dup
        shape.override_source(new_source.merge(p.process(source)))
      end
    end

  end
end
