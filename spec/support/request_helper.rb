module Aragog
  module Spec

    module RequestHelper

      def successful_request
        build_request(:response => successful_response)
      end

      def build_request(options)
        request = Aragog::Request.new '/'
        request.stubs(:response).returns(options[:response])
        request
      end

      def successful_response
        build_response :status => 200
      end

      def build_response(options)
        default_options = {
          :status   => 200,
          :headers  => {},
          :body     => ["<html><body></body></html>"]
        }
        options = default_options.merge(options)

        Rack::MockResponse.new options[:status], options[:headers], options[:body]
      end

    end

  end
end
