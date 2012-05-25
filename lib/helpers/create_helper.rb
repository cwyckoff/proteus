require 'active_support/core_ext'

class CreatePrepping

  attr_accessor :prepping

  def initialize(field)
    @field_name = field
    @prepping = []
    @mapped_name = nil
  end

  def add(prepper)
    handle_options prepper, Preppers.const_get(prepper.camelize).options
  end

  def test_with(sample)
    source = HashWithIndifferentAccess.new(@field_name.to_s => sample)
    field_prepper = FieldPrepper.new({@field_name.to_s => @prepping})

    result = field_prepper.process(source)

    puts "Your prepper, provided the value '#{sample}', will result in ->"
    puts "{ '#{result.first.first}' => '#{result.first.last}' }"
  end

  private

  def handle_options(prepper, options)
    
    config = options.inject({}) do |collection, (opt, example)|
      unless (match = opt.to_s.scan(/dependent_on_(.+)/).flatten).empty?
        collection[match.first]
      else
        # Use #inspect in case of non-string example arguments (arrays, etc)

        puts "#{opt} [example: '#{example.inspect}']: "
        print "=> "
        val = gets.chomp

        val = example.is_a?(String) ? val : eval(val)
        collection.merge({opt.to_s => val})
      end
    end

    config['key'] = @mapped_name if @mapped_name
    @mapped_name = config['target'] if config.has_key?('target')

    @prepping << config.merge("prep" => prepper)
  end
  
  def handle_output
  end
end


def create_prepping(field)
  CreatePrepping.new(field)
end
