module Protean
  module Transformations
    class Collection
      include Enumerable
      attr_reader :field_name, :transformations, :children
      
      def initialize(field)
        @field_name, @transformations = field
      end

      def <<(t)
        transformations << t
      end
      
      def each
        transformations.each do |transformation|
          yield Transformations.instance_for(field_name, transformation)
        end
      end
      
      def children
        @children ||= (
                       children = transformations.select {|t| t.keys.include?("sub_trans")}.first.try(:[],"sub_trans")
                       transformations.delete_if {|t| t.keys.include?("sub_trans")}
                       children || []
                       )
      end
      
      def have_children?
        !children.empty?
      end
      
      alias :has_children? :have_children?

      def to_a
        transformations
      end
      
    end
  end
end
