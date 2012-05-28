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

    config.inject({}) do |target, field|
      protean_field = Protean::Field.new(field)
      transformed_field = protean_field.transform(source)
      target.merge(transformed_field)
    end
  end

  def self.order(hsh, order)
    Hash[hsh.sort_by {|key,value| order.index(key)}]
  end

end
