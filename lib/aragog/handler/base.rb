module Aragog
  module Handler
    class Base

      attr_accessor :request, :passed

      def self.handle(request)
        new(request).tap do |handler|
          handler.handle
          Aragog.report handler
        end
      end

      def initialize(req)
        self.request = req
      end

      def handle
        raise NotImplementedError
      end

      def failure_message
        raise NotImplementedError
      end

      def passed?
        passed
      end

      def failed?
        !passed?
      end

    end
  end
end
