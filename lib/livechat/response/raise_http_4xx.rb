module LiveChat
  class Error < StandardError
    attr_reader :http_headers

    def initialize(message, headers)
      @http_headers = Hash[headers]
      super message
    end
  end

  class BadRequest    < Error; end
  class Unauthorized  < Error; end
  class Forbidden     < Error; end
  class NotFound      < Error; end
  class NotAcceptable < Error; end
  class Chill         < Error; end

  module Response
    class RaiseHttp4xx < Faraday::Response::Middleware
      def on_complete(env)
        case env[:status].to_i
        when 400
          raise LiveChat::BadRequest.new(error_message(env), env[:response_headers])
        when 401
          raise LiveChat::Unauthorized.new(error_message(env), env[:response_headers])
        when 403
          raise LiveChat::Forbidden.new(error_message(env), env[:response_headers])
        when 404
          raise LiveChat::NotFound.new(error_message(env), env[:response_headers])
        when 406
          raise LiveChat::NotAcceptable.new(error_message(env), env[:response_headers])
        when 420
          raise LiveChat::Chill.new(error_message(env), env[:response_headers])
        end
      end

      private ###################################################

      def error_message(env)
        "#{env[:method].to_s.upcase} #{env[:url]}: #{env[:status]}#{error_body(env[:body])}"
      end

      def error_body(body)
        if body.nil?
          nil
        elsif body.is_a? Hashie::Mash
          ": #{body["error"].title} #{body['error'].message}"
        elsif body.is_a? Array
          ": #{body.join(' ')}"
        elsif body["errors"]
          first = body["error"][0]
          if first.kind_of? Hash
            ": #{first["message"].chomp}"
          else
            ": #{first.chomp}"
          end
        end
      end
    end
  end
end
