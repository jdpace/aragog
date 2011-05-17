module Aragog
  class Request
    include Comparable

    attr_reader :uri, :method, :params, :initialized_at, :response, :handlers, :children

    def initialize(uri, options = {})
      @uri = uri
      @method = options[:method] || :get
      @params = options[:params] || {}

      @initialized_at = Time.now
    end

    def perform
      Aragog.driver.process(method, uri, params)
      @response = Aragog.driver.response
      @children = find_children
    end

    def performed?
      !!response
    end

    def handle
      @handlers = Aragog.configuration.handlers.map do |handler_klass|
        handler = handler_klass.handle(self)
      end
    end

    def successful?
      response.successful?
    end

    def <=>(other)
      return 0 if uri == other.uri && method == other.method && params == other.params

      if method.to_sym == other.method.to_sym
        initialized_at <=> other.initialized_at
      else
        method_order = [:get, :post, :put, :delete]
        method_order.index(method.to_sym) <=> method_order.index(other.method.to_sym)
      end
    end

    private

    def find_children
      return [] unless performed? && response.content_type.match(/html/i)

      Aragog.driver.find('//a[@href]').
        reject { |link| link['href'].match /^[javascript|mailto]/i }.
        map    { |link| Request.new link['href'], :method => link['data-method'] }
    end

  end
end
