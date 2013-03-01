require 'rack-statsd'

module Vivaldi
  module Instrument
    class RackMiddleware < RackStatsD::ProcessUtilization
      def initialize(app, domain = "app", options = {})
        options[:stats] = Vivaldi::Instrument
        options[:hostname] = nil unless options.has_key?(:hostname)
        super(app, domain, "", options)
      end

      def procline
        $0
      end

      def call(env)
        @start = Time.now
        GC.clear_stats if @track_gc

        @total_requests += 1
        first_request if @total_requests == 1

        env['process.request_start'] = @start.to_f
        env['process.total_requests'] = total_requests

        # newrelic X-Request-Start
        env.delete('HTTP_X_REQUEST_START')

        status, headers, body = @app.call(env)
        record_request(status, env)
        [status, headers, body]
      end
    end
  end
end
