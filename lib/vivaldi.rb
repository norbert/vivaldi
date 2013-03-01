require 'singleton'

require 'vivaldi/conductor'
require 'vivaldi/instrument'
require 'vivaldi/listener'
require 'vivaldi/note'

require 'vivaldi/configuration'

module Vivaldi
  module Instrument
    autoload :ActiveSupportNotifications, 'vivaldi/instrument/activesupport'
    autoload :ActiveRecordSQL, 'vivaldi/instrument/activerecord_sql'
    autoload :RackMiddleware, 'vivaldi/instrument/rack_middleware'
  end

  module Listener
    autoload :Statsd, 'vivaldi/listener/statsd'
  end

  autoload :Logging, 'vivaldi/logging'
end
