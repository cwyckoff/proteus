module Protean
  module Transformations
    class AddTimestamp < Base

      # {
      #   "trans" => "add_timestamp"
      # }

      def process(shape)
        Time.zone = "US/Central"
        shape.update_value(Time.now.in_time_zone.strftime("%Y-%m-%d %H:%M:%S %Z"))
      end

    end
  end
end
