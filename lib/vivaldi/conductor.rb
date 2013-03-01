module Vivaldi
  class Conductor
    include Singleton

    attr_reader :configuration

    def initialize
      @configuration = Configuration.new
    end

    class << self
      extend Forwardable
      def_delegators :instance, :observe, :configure, :configuration
    end

    def configure
      configuration = Configuration.new
      yield configuration if block_given?

      stop!

      @configuration = configuration
      start!
    end

    def start!
      instruments.each do |instrument|
        instrument.start! if instrument.respond_to?(:start!)
      end
      true
    end

    def stop!
      instruments.each do |instrument|
        instrument.stop! if instrument.respond_to?(:stop!)
      end
      true
    end

    def instruments
      configuration.instruments
    end

    def listeners
      configuration.listeners
    end

    def observe(note)
      listeners.each do |listener|
        listener.observe(note)
      end
      note
    end
  end
end
