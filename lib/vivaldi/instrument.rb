require 'singleton'

module Vivaldi
  module Instrument
    @names = {}

    def self.score(name, klass)
      @names[name] = klass
    end

    def self.play(name, *args, &block)
      if klass = @names[name]
        if klass.included_modules.include?(Singleton)
          klass.instance
        else
          klass.new(*args, &block)
        end
      end
    end

    extend self

    def count(key, value, rate = nil)
      register(:count, key, value, rate)
    end

    def increment(key, rate = nil)
      count(key, 1, rate)
    end

    def decrement(key, rate = nil)
      count(key, -1, rate)
    end

    def gauge(key, value, rate = nil)
      register(:gauge, key, value, rate)
    end

    def timing(key, value, rate = nil)
      register(:timing, key, Float(value).round, rate)
    end

    def set(key, value, rate = nil)
      register(:set, key, value, rate)
    end

    def register(type, key, value, rate = nil)
      note = Note.new(type, key, value, rate)
      Conductor.observe(note)
    end
  end
end
