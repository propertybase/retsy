module Retsy
  class Client
    module Count
      def count(params)
        body = request(
          response_arguments[:search],
          params.merge(
            count: 2,
          )
        ).body
        Retsy::Tools::RetsResponseParser.validate!(body)
        body["COUNT"].attributes["Records"].to_i
      end
    end
  end
end
