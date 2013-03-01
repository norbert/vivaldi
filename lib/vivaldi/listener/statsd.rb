require 'statsd'

module Vivaldi
  module Listener
    class Statsd
      extend Forwardable

      attr_reader :options

      def initialize(*args)
        @options = args
      end

      def delegate
        @delegate ||= ::Statsd.new(*options)
      end

      def observe(note)
        delegate.send(note.type, *note.arguments)
      end
    end
  end
end
