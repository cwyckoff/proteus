module Preppers

  class Clone < Prepper
    
    # {
    #   "prep" => "clone",
    #   "targets" => ["cloned_field", "second_cloned_field"]
    # }
    
    def prep(fields_proxy)
      super(fields_proxy)

      value = fields_proxy.source[key]
      @config["targets"].each do |target|
        fields_proxy.target[target] = value
      end
    end

  end

end
