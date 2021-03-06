$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
require 'active_support/core_ext'
require 'active_support/time'
require 'rspec'

require 'init'

module Protean

  module Transformations
    class Rogue < Base
      def process(shape)
        shape.original[shape.key] = "a new value"
      end
    end
  end

end
