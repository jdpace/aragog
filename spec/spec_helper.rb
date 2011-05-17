SPEC_ROOT = File.dirname(__FILE__)
$LOAD_PATH.unshift(SPEC_ROOT)
$LOAD_PATH.unshift(File.join(SPEC_ROOT, '..', 'lib'))

require 'aragog'
require 'rspec'
require 'rspec/autorun'
require 'mocha'

Dir[ File.join(SPEC_ROOT, 'support', '**', '*.rb') ].each {|f| require f}

RSpec.configure do |config|

  config.color_enabled = true
  config.filter_run :focused => true
  config.run_all_when_everything_filtered = true
  config.alias_example_to :fit, :focused => true
  config.alias_example_to :they

  config.mock_with :mocha

  config.before do
    Aragog.configuration.app = DummyApp.new
    Aragog.configuration.verbose = false
  end

  config.include Aragog::Spec::RequestHelper

end
