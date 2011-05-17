module Aragog
  module Handler
    class Status < Base

      SuccessfulStatusCodes = [200, 201, 401]

      def handle
        self.passed = SuccessfulStatusCodes.include?(status)
      end

      def failure_message
        "Expected a response status to be one of #{SuccessfulStatusCodes.inspect} but got a status of #{status}"
      end

      private

      def status
        request.response.status.to_i
      end

    end
  end
end
