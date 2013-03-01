module Vivaldi
  module Instrument
    module KeyPrefix
      attr_accessor :key_prefix

      def register(type, key, value, rate = nil)
        key = key_with_prefix(key)
        super(type, key, value, rate)
      end

      def key_with_prefix(key)
        @key_prefix ? "#{@key_prefix}.#{key}" : key.to_s
      end
    end
  end
end
