require "retsy/configurable"
require "retsy/client/http"

module Retsy
  class Client
    include Retsy::Client::Http

    attr_reader :login_url, :username, :password, :response_arguments

    def initialize(options = {})
      Retsy::Configurable.keys.each do |key|
        if options[key]
          instance_variable_set("@#{key}", options[key])
        end
      end
    end

    def base_url
      return @base_url if @base_url

      uri = URI.parse(login_url)

      @base_url = "#{uri.scheme}://#{uri.host}"
    end

    def login_path
      return @login_path if @login_path

      @login_path = URI.parse(login_url).path
    end

    def response_arguments
      return @response_arguments if @response_arguments

      rets_resonse = http.get(login_url).body["RETS"]["RETS_RESPONSE"]
      @response_arguments = Retsy::Tools::ResponseArgumentsParser.parse(
        rets_resonse
      )
    end
  end
end
