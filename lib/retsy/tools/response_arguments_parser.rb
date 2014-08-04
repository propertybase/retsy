require "retsy/monkey_patches/string"

module Retsy
  module Tools
    module ResponseArgumentsParser
      extend self

      def parse(input)
        input.
          split("\n").
          map{|line| line.strip}.
          reject{|l| l == nil || l.empty?}.
          inject({}) do |hash, line|
            key, value = line.split("=")
            hash.merge!(key.retsy_underscore.to_sym => value)
          end
      end
    end
  end
end
