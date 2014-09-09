module Retsy
  class Client
    module Search
      def search(params)
        body = request(
          response_arguments[:search],
          params,
        ).body
        begin
          Retsy::Tools::RetsResponseParser.validate!(body)
          delimiter = body["DELIMITER"]["value"].to_i.chr
          columns = body["COLUMNS"].split(delimiter)
          Array(body["DATA"]).map do |data|
            Hash[
              columns.zip(data.split(delimiter)).
                reject { |k, _| k.nil? || k == "" }
            ]
          end
        rescue Retsy::NoRecordsFoundError
          []
        end
      end
    end
  end
end
