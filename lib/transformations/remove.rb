module Preppers

  class Remove < Prepper
    
    # {
    #   "prep" => "remove",
    #   "field" => "last_name",
    #   "if" => "blank?"
    # }
    
    def prep(fields_proxy)

      if @config.has_key?("keys")
        @config["keys"].each do |k|
          fields_proxy.target.delete(k)
          fields_proxy.source.delete(k)
        end
        return false
      end

      if !@config.has_key?("if") or fields_proxy.source[key].send(@config["if"])
        fields_proxy.target.delete(key)
        fields_proxy.source.delete(key)
        return true
      else
        fields_proxy.target[key] = fields_proxy.source[key]
        return false
      end
      
    end

  end

end
