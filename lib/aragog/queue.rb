require 'forwardable'

module Aragog
  class Queue
    extend Forwardable

    attr_reader :requests

    def_delegator :requests, :shift, :pop
    def_delegator :requests, :empty?, :empty?
    def_delegator :requests, :include?, :include?
    def_delegator :requests, :size, :size

    def initialize(*reqs)
      self.requests = reqs
    end

    def requests=(reqs)
      @requests = reqs
      requests.sort!
    end

    def push(req)
      requests << req
      requests.sort!
    end

  end
end
