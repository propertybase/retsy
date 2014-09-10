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
        begin
          Retsy::Tools::RetsResponseParser.validate!(body)
          count_wrapper = body["COUNT"]
          count_wrapper ? count_wrapper["Records"].to_i : 0
        rescue Retsy::NoRecordsFoundError
          0
        end
      end
    end
  end
end
