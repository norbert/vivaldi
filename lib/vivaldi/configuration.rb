module Vivaldi
  class Configuration
    attr_reader :instruments, :listeners

    def initialize
      @instruments = []
      @listeners = []
    end

    def instrument(name, *args, &block)
      instrument = Instrument.play(name, *args, &block)
      if instrument.nil?
        raise ArgumentError, "unknown instrument: #{name.inspect}"
      end

      @instruments << instrument
      instrument
    end

    def listen(klass, *args)
      listener = klass.new(*args)

      @listeners << listener
      listener
    end

    def logging(&block)
      return unless defined?(::Logging)

      listener = Vivaldi::Logging.instance
      yield listener.logger if block_given?

      @listeners << listener
      listener
    end
  end

  def self.configure(&block)
    Conductor.configure(&block)
  end

  def self.configuration
    Conductor.configuration
  end
end
