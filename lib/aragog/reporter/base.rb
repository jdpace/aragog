module Aragog
  module Reporter
    class Base

      attr_accessor :options

      def initialize(opts = {})
        self.options = self.class.default_options.merge(opts)
      end

      def self.default_options
        @default_options || {}
      end

      def self.default_options=(opts)
        @default_options = opts
      end

      # To be implemented by the subclass
      def report(handler)
        raise NotImplementedError
      end

      private

      def print(msg)
        super(msg) if Aragog.configuration.verbose
      end

      def puts(msg)
        super(msg) if Aragog.configuration.verbose
      end

    end
  end
end
