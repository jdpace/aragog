module Aragog
  module Reporter
    class Progress < Base

      def report(handler)
        print( handler.passed? ? '.' : 'F' )
      end

    end
  end
end
