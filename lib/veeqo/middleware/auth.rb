module Veeqo
  module Middleware
    class Auth < Faraday::Middleware
      def initialize(app, options = {})
        @app = app
        @options = options
      end

      def call(env)
        env[:request_headers]['Authorization'] = "Bearer #{@options[:token]}" if @options[:token]
        env[:request_headers]['x-api-key'] = @options[:api_key] if @options[:api_key]
        env[:request_headers]['x-api-request'] = 'true'
        @app.call env
      end
    end
  end
end
