module Aragog
  module Driver

    class NoAppError < StandardError
      def initialize
        super 'You must specifiy an app to run Aragog against'
      end
    end

    module Helpers
      def driver
        app = Aragog.configuration.app
        raise NoAppError unless app

        @driver ||= Aragog.configuration.driver.new(app)
      end
    end

  end
end

Aragog.extend(Aragog::Driver::Helpers)
