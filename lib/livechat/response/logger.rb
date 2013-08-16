module Livechat
  module Response
    class Logger < Faraday::Response::Middleware
      def on_complete(env)
#         puts env[:method].to_s.upcase
#         puts env[:request_headers].inspect
#         puts env[:response_headers].inspect
         puts env[:body].inspect
      end
    end
  end
end
