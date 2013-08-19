module LiveChat
  module REST
    class Client
      include LiveChat::Util
      include LiveChat::REST::Utils

      API_VERSION = '2'

      HTTP_HEADERS = {
        'Accept' => 'application/json',
        'Accept-Charset' => 'utf-8',
        'User-Agent' => "livechat-ruby/#{LiveChat::VERSION}",
        'X-API-Version' => API_VERSION
      }

      DEFAULTS = {
        :host => 'api.livechatinc.com',
        :port => 443,
        :use_ssl => true,
        :ssl_verify_peer => true,
        :ssl_ca_file => File.dirname(__FILE__) + '/../../../conf/cacert.pem',
        :timeout => 30,
        :proxy_addr => nil,
        :proxy_port => nil,
        :proxy_user => nil,
        :proxy_pass => nil,
        :retry_limit => 1,
      }

      attr_reader :login, :last_request, :last_response

      %w(agents canned_responses chats goals groups reports status visitors).each do |r|
        define_method(r.to_sym) do |*args|
          klass = LiveChat::REST.const_get r.capitalize
          n = klass.new("/#{r}", self)
          if args.length > 0
            n.get(args[0])
          else 
            n
          end
        end
      end

      ##
      # Instantiate a new HTTP client to talk to LiveChat. The parameters
      # +login+ and +api_key+ are required and used to generate the
      # HTTP basic auth header in each request.
      #
      def initialize(login, api_key, options={})
        @login, @api_key = login.strip, api_key.strip
        @config = DEFAULTS.merge! options
        set_up_connection
      end

      def inspect # :nodoc:
        "<LiveChat::REST::Client @login=#{@login}>"
      end

      ##
      # Define #get, #put, #post and #delete helper methods for sending HTTP
      # requests to LiveChat. You shouldn't need to use these methods directly,
      # but they can be useful for debugging. Each method returns a hash
      # obtained from parsing the JSON object in the response body.
      [:get, :put, :post, :delete].each do |method|
        method_class = Net::HTTP.const_get method.to_s.capitalize
        define_method method do |path, *args|
          params = restify args[0]; params = {} if params.empty?
          unless args[1] # build the full path unless already given
            path = "#{path}"
            path << "?#{url_encode(params)}" if method == :get && !params.empty?
          end
          request = method_class.new path, HTTP_HEADERS
          request.basic_auth @login, @api_key
          request.form_data = params if [:post, :put].include? method
          connect_and_send request
        end
      end

      private

      ##
      # Set up and cache a Net::HTTP object to use when making requests. This is
      # a private method documented for completeness.
      def set_up_connection # :doc:
        connection_class = Net::HTTP::Proxy @config[:proxy_addr],
          @config[:proxy_port], @config[:proxy_user], @config[:proxy_pass]
        @connection = connection_class.new @config[:host], @config[:port]
        set_up_ssl
        @connection.open_timeout = @config[:timeout]
        @connection.read_timeout = @config[:timeout]
      end
 
      ##
      # Set up the ssl properties of the <tt>@connection</tt> Net::HTTP object.
      # This is a private method documented for completeness.
      def set_up_ssl # :doc:
        @connection.use_ssl = @config[:use_ssl]
        if @config[:ssl_verify_peer]
          @connection.verify_mode = OpenSSL::SSL::VERIFY_PEER
          @connection.ca_file = @config[:ssl_ca_file]
        else
          @connection.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
      end


      ##
      # Send an HTTP request using the cached <tt>@connection</tt> object and
      # return the JSON response body parsed into a hash. Also save the raw
      # Net::HTTP::Request and Net::HTTP::Response objects as
      # <tt>@last_request</tt> and <tt>@last_response</tt> to allow for
      # inspection later.
      def connect_and_send(request) # :doc:
        @last_request = request
        retries_left = @config[:retry_limit]
        begin
          response = @connection.request request
          @last_response = response
          if response.kind_of? Net::HTTPServerError
            raise LiveChat::REST::ServerError
          end
        rescue Exception
          raise if request.class == Net::HTTP::Post
          if retries_left > 0 then retries_left -= 1; retry else raise end
        end
        if response.body and !response.body.empty?
          object = MultiJson.load response.body
        end
        if response.kind_of? Net::HTTPClientError
          raise LiveChat::REST::RequestError.new object['message'], object['code']
        end
        object
      end
    end
  end
end
