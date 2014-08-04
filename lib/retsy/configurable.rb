module Retsy
  module Configurable
    class << self

      # List of configurable keys for {Retsy::Client}
      # @return [Array] of option keys
      def keys
        @keys ||= [
          :login_url,
          :username,
          :password,
        ]
      end
    end
  end
end
