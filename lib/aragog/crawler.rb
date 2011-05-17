module Aragog
  class Crawler

    attr_accessor :queue, :processed

    def initialize(seed_uri, options = {})
      self.queue = Queue.new Request.new(seed_uri, options)
      self.processed = []
    end

    def crawl
      until queue.empty?
        request = queue.pop

        request.perform
        request.handle

        enqueue request.children
        # enqueue request.fuzzes

        processed << request
      end
    end

    private

    def enqueue(requests)
      requests.each do |request|
        queue.push(request) unless queue.include?(request) || processed.include?(request)
      end
    end

  end
end
