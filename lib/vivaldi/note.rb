module Vivaldi
  class Note < Struct.new(:type, :key, :value, :option)
    TYPES = [:count, :gauge, :timing, :set]

    def initialize(type, key, value, option = nil)
      if TYPES.include?(type)
        self.type = type
      else
        raise ArgumentError, "invalid type: #{type.inspect}"
      end
      self.key = key
      self.value = value
      self.option = option
    end

    def arguments
      return @arguments if @arguments
      @arguments = [key, value]
      option.nil? ? @arguments : @arguments.push(option)
    end
  end
end
