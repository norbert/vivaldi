module Vivaldi
  class Note < Struct.new(:type, :key, :value, :rate)
    TYPES = [:count, :gauge, :timing, :set]

    attr_reader :arguments

    def initialize(type, key, value, rate = nil)
      if TYPES.include?(type)
        self.type = type
      else
        raise ArgumentError, "invalid type: #{type.inspect}"
      end
      self.key = key.to_s.freeze
      self.value = value.is_a?(Numeric) ? value : Float(value)
      self.rate = rate.nil? ? 1.0 : Float(rate)
      @arguments = [self.key, self.value]
      @arguments.push(self.rate)
    end
  end
end
