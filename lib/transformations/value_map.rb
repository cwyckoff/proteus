module Preppers

  class ValueMap < Prepper

    # {
    #   "prep" => "value_map"
    #   "key" => "source_id",
    #   "mappings" => {
    #     "old_value" => "new_value"
    #   },
    #   "default" => "some_value"
    # }
    
    def prep(fields_proxy)
      super(fields_proxy)

      val =  @config["mappings"].key?(fields_proxy.source[key]) ? @config["mappings"][fields_proxy.source[key]] : @config["default"]

      fields_proxy.target[key] = val
      
    end

 end

end
