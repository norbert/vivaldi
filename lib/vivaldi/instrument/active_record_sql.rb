require 'vivaldi/instrument/active_support_notifications'

module Vivaldi
  module Instrument
    class ActiveRecordSQL < ActiveSupportNotifications
      include Instrument::KeyPrefix

      SOURCE_NAME = "sql.active_record"
      KEY_PREFIX = "active_record.sql"

      QUERY_ESCAPE_REGEXP = /`|"/
      QUERY_TABLE_REGEXP = /#{QUERY_ESCAPE_REGEXP}(\w+)#{QUERY_ESCAPE_REGEXP}/
      QUERY_SELECT_DELETE_REGEXP = / FROM #{QUERY_TABLE_REGEXP}/
      QUERY_INSERT_REGEXP = /^INSERT INTO #{QUERY_TABLE_REGEXP}/
      QUERY_UPDATE_REGEXP = /^UPDATE #{QUERY_TABLE_REGEXP}/

      def initialize(key_prefix = nil)
        super(SOURCE_NAME)
        self.key_prefix = key_prefix || KEY_PREFIX
      end

      def play(event)
        payload = event.payload

        case payload[:sql]
        when /^SELECT/
          increment :select
          if payload[:sql] =~ QUERY_SELECT_DELETE_REGEXP
            timing :select, $1
          end
        when /^INSERT/
          increment :insert
          if payload[:sql] =~ QUERY_INSERT_REGEXP
            timing :insert, $1
          end
        when /^UPDATE/
          increment :update
          if payload[:sql] =~ QUERY_UPDATE_REGEXP
            timing :update, $1
          end
        when /^DELETE/
          increment :delete
          if payload[:sql] =~ QUERY_SELECT_DELETE_REGEXP
            timing :delete, $1
          end
        else
          increment :query
        end

        event
      end

      def timing(type, table)
        key = "#{table}.#{type}.query_time"
        super(key)
      end

      def register(*args)
        super
      end
    end

    score :active_record_sql, ActiveRecordSQL
  end
end
