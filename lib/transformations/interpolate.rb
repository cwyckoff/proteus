module Protean
  module Transformations
    class Interpolate < Base

      # {
      #   "trans" => "interpolate",
      #   "format" => "[last_name] - [first_name]"
      # }

      def process(shape)
        shape.update_value(interpolate(shape))
      end

      private

      def interpolate(shape)
        blueprint["format"].gsub(/\[([\w\d]+)\]/) do |match|
          key = match.gsub("[", "").gsub("]", "")
          shape.original[key]
        end
      end

    end
  end
end
