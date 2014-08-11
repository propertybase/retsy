module Retsy
  class Client
    module Metadata
      def metadata(params)
        body = request(response_arguments[:get_metadata], params).body
        body["METADATA"][params[:type].gsub(/-/, "_")]
      end
    end
  end
end
