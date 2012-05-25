module Preppers

  class DateTime < Prepper

    # {
    #   "key" => "timestamp",
    #   "map" => "date",
    #   "format" => "%Y/%m/%d",
    #   "target" => "lead_date", # optional
    #   "timezone" => "US/Pacific" # optional
    # }

    def prep(fields_proxy)
      super(fields_proxy)

      time = fields_proxy.source[key]
      raise Preppers::MissingTimezone.new("All dates must have a timezone.") unless Time.ensure_zone(time)

      time = Time.parse(time)

      if @config["method"]
        time = time.utc.send(@config["method"])
      else 
        if @config.has_key?("timezone")
          time = time.utc
          time = time.in_time_zone(@config["timezone"])
        end
        time = time.strftime(@config["format"])
      end

      fields_proxy.target[@config["target"]] = time
    end

  end
end
