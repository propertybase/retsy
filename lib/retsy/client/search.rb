module Retsy
  class Client
    module Search
      def search(params)
        body = request(
          response_arguments[:search],
          params.merge(
            querytype: "DMQL2",
          )
        ).body
        begin
          Retsy::Tools::RetsResponseParser.validate!(body)
          result = body["REData"]
          wrapped = result.is_a?(Hash) ? [result] : result
          wrapped.map{|l| l.fetch("REProperties").fetch(params[:class])}
        rescue Retsy::NoRecordsFoundError
          []
        end
      end
    end
  end
end
