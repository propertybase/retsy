module Retsy
  class Client
    module Search
      def search(params)
        request(response_arguments[:search], params).body
      end
    end
  end
end
