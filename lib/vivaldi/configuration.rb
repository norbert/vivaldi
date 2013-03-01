module Vivaldi
  class Configuration
    attr_reader :instruments, :listeners

    def initialize
      @instruments = []
      @listeners = []
    end

    def instrument(instrument_or_name, *args, &block)
      instrument = if instrument_or_name.respond_to?(:play)
        if args.empty?
          instrument_or_name
        else
          raise ArgumentError, "invalid call signature"
        end
      elsif
        Instrument.play(instrument_or_name, *args, &block)
      else
        raise ArgumentError, "unknown instrument: #{instrument_or_name.inspect}"
      end

      @instruments << instrument
      instrument
    end

    def listen(listener_or_klass, *args)
      listener = if listener_or_klass.is_a?(Class)
        listener_or_klass.new(*args)
      elsif listener_or_klass.respond_to?(:observe)
        if args.empty?
          listener_or_klass
        else
          raise ArgumentError, "invalid call signature"
        end
      else
        raise ArgumentError, "invalid listener"
      end

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
