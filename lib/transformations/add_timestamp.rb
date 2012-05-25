module Preppers

  class AddTimestamp < Prepper

    # {
    #   "field" => "delivery_date",
    #   "prep" => "add_timestamp"
    # }

    def prep(fields_proxy)
      super(fields_proxy)

      Time.zone = "US/Central"
      fields_proxy.target[key] = Time.zone.now.strftime("%Y-%m-%d %H:%M:%S %Z")
    end

  end

end
