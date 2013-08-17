require "livechat/connection"
require "livechat/paginator"

module LiveChat
  class Collection
    include Paginator  # `clear_cache`, `fetch`, `each`, `[]`, `page`, `per_page`, `method_missing`
    include Connection

    attr_accessor *Config::VALID_OPTIONS_KEYS

    def initialize(client, resource, *args)
      clear_cache

      @client   = client
      @resource = resource
      @path     = resource_path(@resource)
      @query    = args.last.is_a?(Hash) ? args.pop : {}

      case selection = args.shift
      when nil
        @query[:path] = @path
      when Integer
        @query[:path] = "#{@path}/#{selection}"
        when String
        @query[:path] = "#{@path}/#{selection}"
      end
    end

    def get(path, options={})
      request(:get, path, options)
    end

    def put(path, options={})
      request(:put, path, options)
    end

    def post(path, options={})
      request(:post, path, options)
    end

    def create(data={})
      yield data if block_given?
      request(:post, @query.delete(:path), @query.merge(@resource => data))
    end

    def update(data={})
      yield data if block_given?
      request(:put, @query.delete(:path), @query.merge(@resource => data))
    end

    def delete(options={})
      request(:delete, @query.delete(:path), options)
    end

    private

    def request(method, path, options)
      # `connection` defined in lib/livechat/connection.rb
      response = connection(@client).send(method) do |request|
        case method
        when :get, :delete
          request.url(formatted_path(path, format), options)
        when :post, :put
          request.path = formatted_path(path, format)
          request.body = options unless options.empty?
        end
        #if @client.debug
        #  puts request
        #end
      end

      response.body
    end

    def formatted_path(path, format)
      [path, format].compact.join(".")
    end

    # ghetto but better than requiring ActiveSupport or writing some inflector myself
    def resource_path(resource)
      {
        :agent => "agents",
        :canned_response => "canned_responses",
        :chat => "chats",
        :goal => "goals",
        :group => "groups",
        :report => "reports",
        :status => "status",
        :visitor => "visitors"
      }[resource]
    end

  end
end
