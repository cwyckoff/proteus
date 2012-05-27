require 'active_support/core_ext'

fp_dir = File.expand_path(File.dirname(__FILE__))
$:.unshift fp_dir


Dir["#{fp_dir}/lib/core_ext/*.rb"].each do |file|
 require file
end

require 'lib/exceptions'
require 'lib/transformations'
require 'lib/transformations/base'
require 'lib/transformations/add_timestamp'
require 'lib/transformations/blank'
require 'lib/transformations/concatenate'
require 'lib/transformations/date'
require 'lib/transformations/interpolate'
require 'lib/transformations/lowercase'
require 'lib/transformations/map'
require 'lib/transformations/phone'
require 'lib/transformations/prepop'
require 'lib/transformations/remove'
require 'lib/transformations/state'
require 'lib/transformations/truncate'
require 'lib/transformations/uppercase'
require 'lib/transformations/value_map'
require 'lib/transformations/zip'
require 'lib/field'
require 'lib/proteus'
