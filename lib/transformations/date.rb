module Protean

  class ProteusInvalidDateType < Exception; end

  module Transformations
    class Date < Base

      # {
      #   "trans" => "date",
      #   "type" => "format"
      #   "format" => "%Y/%m/%d",
      #   "timezone" => "MST"
      # }

      # {
      #   "trans" => "date",
      #   "type" => "format"
      #   "format" => "%Y/%m/%d",
      # }

      # {
      #   "trans" => "date",
      #   "type" => "iso8601"
      # }

      def process(shape)
        time = shape.value
        return time if time.blank?

        time = Time.parse(time)

        case blueprint["type"]
        when "format"
          time = time.in_time_zone(blueprint["timezone"]) if blueprint["timezone"].present?
          time = time.strftime(blueprint["format"])
        when "iso8601"
          time = time.utc.iso8601
        else
          raise ProteusInvalidDateType
        end

        shape.update_value(time)
      end

    end
  end
end
