require File.dirname(__FILE__) + "/../init"

class Proteus
  attr_reader :config
  
  def initialize(config)
    @config = config
  end

  # Proteus.new({}).process(lead_data)
  def process(source)
    source = HashWithIndifferentAccess.new(source)
    source.freeze
    
    config.inject({}) do |target, transformations|
      field = Protean::Field.new(transformations)
      transformed = field.transform(source)
      target.merge(transformed)
    end
  end

end
