module Retsy
  module MultipartParser
    extend self

    def parse(response)
      boundary = fetch_boundary(response.headers)
      response.body.split("\r\n--#{boundary}").
        reject { |part| part == "" || part == "--\r\n" || part == "\r\n" }.
        map { |part| convert_to_hash(part) }
    end

    private

    def fetch_boundary(multipart_headers)
      multipart_headers["content-type"].split("=").last
    end

    def convert_to_hash(response)
      headers_string, body = response.split("\r\n\r\n", 2)
      headers_array = headers_string.
                        split("\r\n").
                        reject { |h| h.nil? || h == "" || h == "--" }
      headers = headers_array.inject({}) do |hash, pair|
        key, value = pair.split(": ")
        hash.merge(key => value)
      end
      {
        headers: headers,
        body: body,
      }
    end
  end
end
