module Aragog
  class Configuration

    attr_accessor :app, :driver, :handlers, :reporter, :verbose, :timeout

    def initialize
      @driver   = Capybara::Driver::RackTest
      @handlers = [ Handler::Status ]
      @reporter = Reporter::Progress.new
      @verbose  = true
      @timeout  = (2*60)
    end

    module Helpers
      def configuration
        @configuration ||= Aragog::Configuration.new
      end

      def configuration=(config)
        @configuration = config
      end

      def configure
        yield(configuration)
      end

      def with_config(config, &block)
        previous_config = @configuration
        @configuration = config
        result = yield
        @configuration = previous_config
        result
      end
    end

  end
end

Aragog.extend(Aragog::Configuration::Helpers)
