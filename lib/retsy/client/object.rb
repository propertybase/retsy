require "retsy/tools/multipart_parser"

module Retsy
  class Client
    module Object
      def object(params)
        response = request(
          response_arguments[:get_object],
          params,
        )
        MultipartParser.parse(response)
      end
    end
  end
end
