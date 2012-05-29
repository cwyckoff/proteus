module Protean
  module DSL
    class FieldDSL

      attr_reader :subject

      def initialize(name)
        @subject = Protean::Field.new([name, []])
      end

      def with(signature, *args)
        signature = signature.to_s
        trans ||= Protean::Transformations.constants.map{|trans| trans.to_s.underscore }.join("|")
        Regexp.new("^(#{trans})_?(.*)").match(signature)
        transformation = {"trans" => $1}
        if $2.present?
          keys = $2.split("_and_")
          transformation.merge!(Hash[keys.zip(args)])
        end
        transformations << Protean::Transformations.instance_for(name, transformation)
        self
      end

      alias :and :with

      def name
        @subject.name
      end

      def transformations
        @subject.transformations
      end

    end
  end
end
