module LiveChat
  # Defines constants and methods related to configuration
  module Config
    # An array of valid keys in the options hash when configuring a {LiveChat::Client}
    VALID_OPTIONS_KEYS = [
      :adapter,
      :endpoint,
      :login,
      :api_key,
      :api_version,
      :format,
      :gateway,
      :proxy,
      :user_agent,
      :debug
    ].freeze

    attr_accessor *VALID_OPTIONS_KEYS

    DEFAULT_ENDPOINT = 'https://api.livechatinc.com'

    DEFAULT_VERSION = '2'

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = :net_http #:patron

    # By default, don't set an application key
    DEFAULT_API_KEY = nil

    # By default, don't use a proxy server
    DEFAULT_PROXY = nil

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "LiveChat Ruby Client #{LiveChat::VERSION}".freeze

    DEFAULT_GATEWAY = nil

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTIONS_KEYS.each {|k| options[k] = send(k)}
      options
    end

    # Reset all configuration options to defaults
    def reset
      self.adapter            = DEFAULT_ADAPTER
      self.endpoint           = DEFAULT_ENDPOINT
      self.login              = nil
      self.api_key            = DEFAULT_API_KEY
      self.api_version        = DEFAULT_VERSION
      self.proxy              = DEFAULT_PROXY
      self.user_agent         = DEFAULT_USER_AGENT
      self.gateway            = DEFAULT_GATEWAY
      self.debug              = false
      self
    end
  end
end
