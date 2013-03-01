require 'singleton'

require 'logging'

module Vivaldi
  class Logging
    include Listener
    include Singleton

    def logger
      @logger ||= ::Logging.logger['Vivaldi']
    end

    def observe(note)
      logger.debug("note=#{note.type} key=#{note.key} value=#{note.value}")
    end
  end
end
