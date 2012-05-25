module Protean
  module Transformations
    class Zip < Base

      # {
      #   "trans" => "zip",
      #   "field" => "base", #or plus4
      # }

      # perform map depending on target
      # the value put into target depends on field
      # only one target will be produced
      def process(shape)
        shape.value =~ /^(\d{5})-?(\d{4})?$/
        value = (blueprint["field"] == "base") ? $1 : $2
        shape.update_value(value)
      end

    end

  end
end
