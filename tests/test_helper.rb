require 'minitest/autorun'
require 'minitest/color'

Dir.glob(File.join(File.dirname(__FILE__), '..', 'lib', '**', '*.rb')) do |f|
  require_relative f
end
