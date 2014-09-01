require "retsy/errors"

module Retsy
  module Tools
    module RetsResponseParser
      extend self

      def validate!(input)
        return_code = input["ReplyCode"]
        return if return_code == "0"

        raise Retsy::ErrorFactory.build(input["ReplyCode"], input["ReplyText"])
      end
    end
  end
end
