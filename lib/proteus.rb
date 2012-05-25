require File.dirname(__FILE__) + "/../init"

class Proteus
  attr_reader :config
  
  def initialize(config)
    @config = config
  end

  def process(source)
    source = HashWithIndifferentAccess.new(source)

    config.inject({}) do |target, transformations|
      field = Protean::Field.new(transformations)
      transformed = field.transform(source)
      target.merge(transformed)
    end
  end

end
