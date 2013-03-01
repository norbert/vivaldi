require 'vivaldi/instrument/activesupport'

module Vivaldi
  module Instrument
    class ActiveRecordSQL < ActiveSupportNotifications
      SOURCE_NAME = "sql.active_record"

      QUERY_ESCAPE_REGEXP = /`|"|.{0}/
      QUERY_TABLE_REGEXP = /(#{QUERY_ESCAPE_REGEXP}(\w+)#{QUERY_ESCAPE_REGEXP})/
      QUERY_SELECT_DELETE_REGEXP = / FROM #{QUERY_TABLE_REGEXP}/
      QUERY_INSERT_REGEXP = /^INSERT INTO #{QUERY_TABLE_REGEXP}/
      QUERY_UPDATE_REGEXP = /^UPDATE #{QUERY_TABLE_REGEXP}/

      def initialize
        super(SOURCE_NAME)
      end

      def play(event)
        payload = event.payload
        case payload[:sql]
        when /^SELECT/
          increment 'sql.select'
          if payload[:sql] =~ QUERY_SELECT_DELETE_REGEXP
            timing "sql.#{$2}.select.query_time"
          end
        when /^INSERT/
          increment 'sql.insert'
          if payload[:sql] =~ QUERY_INSERT_REGEXP
            timing "sql.#{$2}.insert.query_time"
          end
        when /^UPDATE/
          increment 'sql.update'
          if payload[:sql] =~ QUERY_UPDATE_REGEXP
            timing "sql.#{$2}.update.query_time"
          end
        when /^DELETE/
          increment 'sql.delete'
          if payload[:sql] =~ QUERY_SELECT_DELETE_REGEXP
            timing "sql.#{$2}.delete.query_time"
          end
        end
      end
    end

    score :activerecord_sql, ActiveRecordSQL
  end
end
