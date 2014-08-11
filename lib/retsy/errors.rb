module Retsy
  module ReplyError
    attr_reader :reply_text, :reply_code

    def initialize(msg, reply_code=nil, reply_text=nil)
      super(msg)
      @reply_code, @reply_text = reply_code, reply_text
    end
  end

  module ErrorFactory
    extend self

    def build(reply_code, reply_text)
      msg = "#{reply_code}: #{reply_text}"
      if reply_code == "20201"
        NoRecordsFoundError.new(msg, reply_code, reply_text)
      else
        ApiError.new(msg, reply_code, reply_text)
      end
    end
  end

  class NoRecordsFoundError < StandardError
    include Retsy::ReplyError
  end

  class ApiError < StandardError
    include Retsy::ReplyError
  end
end
