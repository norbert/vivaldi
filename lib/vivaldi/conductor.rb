module Vivaldi
  class Conductor
    include Singleton

    attr_reader :configuration

    def initialize
      @active = false
      @configuration = Configuration.new
    end

    class << self
      extend Forwardable
      def_delegators :instance, :observe, :configure, :configuration
    end

    def active?
      @active
    end

    def configure
      configuration = Configuration.new
      yield configuration if block_given?

      stop!

      @configuration = configuration
      start!
    end

    def start!
      @active = true

      instruments.each do |instrument|
        instrument.start! if instrument.respond_to?(:start!)
      end

      true
    end

    def stop!
      return false unless active?

      @active = false

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
      return unless active?

      listeners.each do |listener|
        listener.observe(note)
      end

      note
    end
  end
end
