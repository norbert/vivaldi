require 'securerandom'
require 'active_support/notifications'

module Vivaldi
  module Instrument
    class ActiveSupportNotifications
      include Instrument

      EVENT_CLASS = ActiveSupport::Notifications::Event

      attr_reader :subscription, :subscriber, :handler

      def initialize(*args, &block)
        if block_given?
          @handler = block
          define_singleton_method(:call, block)
        end
        @subscription = args

        subscribe!
      end

      def subscribe!
        return if subscribed?
        @subscriber = ActiveSupport::Notifications.subscribe(*subscription) do |*args|
          begin
            @event = EVENT_CLASS.new(*args)
            play(@event)
          ensure
            @event = nil
          end
        end
      end
      alias_method :start!, :subscribe!

      def unsubscribe!
        ActiveSupport::Notifications.unsubscribe(subscriber) if subscribed?
      end
      alias_method :stop!, :unsubscribe!

      def subscribed?
        !!subscriber
      end

      def play(event)
        call(event) if @handler
      end

      def timing(key, value_or_event = nil, rate = 1)
        if value_or_event.nil?
          value_or_event = @event
        end
        if value_or_event.is_a?(EVENT_CLASS)
          value_or_event = value_or_event.duration
        end
        super(key, value_or_event, rate)
      end
    end

    score :activesupport, ActiveSupportNotifications
  end
end
