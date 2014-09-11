require "spec_helper"
require "retsy/tools/multipart_parser"

module Retsy
  describe MultipartParser do
    subject { described_class }

    let(:response) do
      OpenStruct.new(
        headers: headers,
        body: body,
      )
    end

    let(:body) do
      "\r\n--#{boundary}" \
      "\r\nContent-Transfer-Encoding: binary" \
      "\r\nContent-ID: 359145" \
      "\r\nObject-ID: 1" \
      "\r\nContent-Type: image/jpeg" \
      "\r\nContent-Length: 126559" \
      "\r\n\r\n" \
      "\xFF\xD8\xFF\xE0\x00\x10JFIF\x00\x01\x01\x01\x00H" \
      "\x00C\x00\x01\x01\x01\x01\x01\x01\x01\x01\x01\x01" \
      "\r\n--#{boundary}--" \
      "\r\nContent-Transfer-Encoding: binary" \
      "\r\nContent-ID: 359145" \
      "\r\nObject-ID: 2" \
      "\r\nContent-Type: image/jpeg" \
      "\r\nContent-Length: 36695" \
      "\r\n\r\n" \
      "\xFF\xD8\xFF\xE0\x00\x10JFIF\x00\x01\x01\x01\x00\x03" \
      "\x00\x03\x00\x00\xFF\xDB\x00C\x00\x02\x01\x01\x02\x01" \
      "\x01\x02\x02\x02\x02\x02\x02\x02\x02\x03\x05\x03\x03" \
      "\x03\x03\x03\x06\x04\x04\x03\x05\a\x06\a\a\a\x06\a" \
      "\a\b\t\v\t\b\b\n\b\a\a\n\r\n\n\v\f\f\f\f\a\t\x0E\x0F" \
      "\r\f\x0E\v\f\f\f\xFF\xDB\x00C\x01\x02\x02\x02\x03\x03\x03" \
      "\x06\x03\x03\x06\f\b\a\b\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f" \
      "\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f" \
      "\f\f\f\xFF\r\n--#{boundary}--\r\n".force_encoding("ASCII-8BIT")
    end
    let(:headers) do
      {
        "cache-control" => "private",
        "content-type" => "multipart/parallel; boundary=#{boundary}",
        "expires" => "Mon, 01 Jan 0001 00:00:00 GMT",
        "server" => "Microsoft-IIS/7.5",
        "rets-server" => "RETS-Paragon/1.0",
        "rets-request-id" => "e4a7dfde04741e75b757d5d5c73cef13",
        "rets-version" => "RETS/1.7.2",
        "mime-version" => "1.0",
        "content-id" => "359145:*",
        "object-id" => "multiple",
        "x-server" => "A51",
        "date" => "Wed, 10 Sep 2014 14:42:07 GMT",
        "connection" => "close",
        "content-length" => "680955"
      }
    end
    let(:boundary) { "2ce97979.83bf.368b.86c2.cc9295f41e3d" }
    let(:expected_output) do
      [
        {
          headers: {
            "Content-Transfer-Encoding" => "binary",
            "Content-ID" => "359145",
            "Object-ID" => "1",
            "Content-Type" => "image/jpeg",
            "Content-Length" => "126559",
          },
          body: "\xFF\xD8\xFF\xE0\x00\x10JFIF\x00\x01\x01\x01\x00H" \
                "\x00C\x00\x01\x01\x01\x01\x01\x01\x01\x01\x01\x01".
                force_encoding("ASCII-8BIT")
        },
        {
          headers: {
            "Content-Transfer-Encoding" => "binary",
            "Content-ID" => "359145",
            "Object-ID" => "2",
            "Content-Type" => "image/jpeg",
            "Content-Length" => "36695",
          },
          body: "\xFF\xD8\xFF\xE0\x00\x10JFIF\x00\x01\x01\x01\x00\x03" \
                "\x00\x03\x00\x00\xFF\xDB\x00C\x00\x02\x01\x01\x02\x01" \
                "\x01\x02\x02\x02\x02\x02\x02\x02\x02\x03\x05\x03\x03" \
                "\x03\x03\x03\x06\x04\x04\x03\x05\a\x06\a\a\a\x06\a" \
                "\a\b\t\v\t\b\b\n\b\a\a\n\r\n\n\v\f\f\f\f\a\t\x0E\x0F" \
                "\r\f\x0E\v\f\f\f\xFF\xDB\x00C\x01\x02\x02\x02\x03\x03\x03" \
                "\x06\x03\x03\x06\f\b\a\b\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f" \
                "\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f" \
                "\f\f\f\xFF".force_encoding("ASCII-8BIT")
        }
      ]
    end

    it "parses multipart request correctly" do
      expect(subject.parse(response)).to eq(expected_output)
    end
  end
end
