require "livechat/connection"

module LiveChat
  module Request
    extend Connection

    def self.get(path, options={})
      request(:get, path, options)
    end

    def self.post(path, options={})
      request(:post, path, options)
    end

    def self.put(path, options={})
      request(:put, path, options)
    end

    def self.delete(path, options={})
      request(:delete, path, options)
    end

    private

    def self.request(method, path, options, format=:json)
      # `connection` defined in lib/livechat/connection.rb
      response = connection(format).send(method) do |request|
        case method
        when :get, :delete
          request.url(formatted_path(path, format), options)
        when :post, :put
          request.path = formatted_path(path, format)
          request.body = options unless options.empty?
        end
      end

      response.body
    end

    def formatted_path(path, format)
      [path, format].compact.join(".")
    end
  end
end
