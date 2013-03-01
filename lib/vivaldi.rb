require 'singleton'

require 'vivaldi/conductor'
require 'vivaldi/instrument'
require 'vivaldi/listener'
require 'vivaldi/note'

require 'vivaldi/configuration'

module Vivaldi
  module Instrument
    autoload :ActiveSupportNotifications, 'vivaldi/instrument/active_support_notifications'
    autoload :ActiveRecordSQL, 'vivaldi/instrument/active_record_sql'
    autoload :RackMiddleware, 'vivaldi/instrument/rack_middleware'
  end

  module Listener
    autoload :Statsd, 'vivaldi/listener/statsd'
  end

  autoload :Logging, 'vivaldi/logging'
end
