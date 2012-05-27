module Protean
  module Transformations

    def self.instance_for(field_name, transformation)
      Transformations.const_get(transformation["trans"].camelize).new(transformation.merge("field" => field_name))
    end

  end
end
