require "faraday"
require "faraday_middleware"
require "livechat/response/logger"
require "livechat/response/raise_http_4xx"

module LiveChat
  module Connection
    private

    # This method sets up HTTP data for all requests
    def connection(client)
      options = {
        :headers => {
          :accept => "application/#{client.format}",
          :user_agent => client.user_agent,
          'X-API-Version' => client.api_version
        },
        :proxy => client.proxy,
        :ssl => {:verify => false},
        :url => 'https://api.livechatinc.com'
      }

      conn = Faraday::Connection.new(options) do |builder|
        # As with Rack, order matters. Be mindful.
        # TODO: builder.use LiveChat::Request::MultipartWithFile
        # TODO: builder.use Faraday::Request::OAuth, authentication if authenticated?
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded
        builder.use LiveChat::Response::RaiseHttp4xx
        builder.use Faraday::Response::Mashify
        case client.format.to_sym
        when :json
          builder.use Faraday::Response::ParseJson
        when :xml
          builder.use Faraday::Response::ParseXml
        end
        #builder.use Faraday::Response::Logger
        # TODO: builder.use Faraday::Response::RaiseHttp5xx
        # finally
        builder.adapter(@client.adapter)
      end

      conn.basic_auth(@client.login, @client.api_key)
      conn
    end
  end
end
