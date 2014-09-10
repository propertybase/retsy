module Retsy
  class Client
    module Metadata
      def metadata(params)
        body = request(response_arguments[:get_metadata], params).body
        (body["METADATA"] || body)[params[:type]]
      end
    end
  end
end
