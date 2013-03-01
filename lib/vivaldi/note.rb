module Vivaldi
  class Note < Struct.new(:type, :key, :value, :option)
    TYPES = [:increment, :timing, :gauge]

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
      list = [key, value]
      list.push(option) if !option.nil?
      list
    end
  end
end
