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

    def increment(key, value = nil, option = nil)
      value ||= 1
      note = Note.new(:increment, key, value, option)
      register(note)
    end

    def gauge(key, value, option = nil)
      note = Note.new(:gauge, key, value, option)
      register(note)
    end

    def timing(key, value, option = nil)
      note = Note.new(:timing, key, value, option)
      register(note)
    end

    def register(note)
      Conductor.observe(note)
    end
  end
end
