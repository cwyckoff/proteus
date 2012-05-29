module Protean
  module DSL
    class ProteusDSL

      attr_reader :subject, :fields, :source

      def initialize
        @subject = Proteus.new({})
        @fields = []
        @source = {}
      end

      def method_missing(m, *args, &block)
        if (match = m.to_s.match(/^_(.+)/))
          existing_field = @fields.select {|field| field.name == $1}.first
          return existing_field if existing_field
          return new_field(m.slice(1..-1), args.first)
        end
        super(m, *args, &block)
      end

      private

      def new_field(name, value = nil)
        @source[name] = value if value
        @fields << field = Protean::DSL::FieldDSL.new(name)
        field
      end
    end
  end
end
