module Retsy
  module XmlSanitizer
    extend self

    def sanitize input
      input.gsub(/&#[0-2]?[0-9];|&#3[0-1];/, " ")
    end
  end
end
