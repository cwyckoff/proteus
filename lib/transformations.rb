module Protean
  module Transformations

    def self.instance_for(field_name, transformation)
      Transformations.const_get(transformation["trans"].camelize).new(transformation.merge("field" => field_name))
    end

    def self.to_regexp
      Transformations.constants.map{|trans| trans.to_s.underscore }.join("|")
    end
    
  end
end
