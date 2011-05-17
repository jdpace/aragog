require 'aragog/reporter/base'
require 'aragog/reporter/progress'

module Aragog
  module Reporter

    module Helpers
      def report(handler)
        reporter.report handler
      end

      def reporter
        @reporter ||= Aragog.configuration.reporter
      end
    end

  end
end

Aragog.extend Aragog::Reporter::Helpers
