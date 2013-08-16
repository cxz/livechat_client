module Livechat
  module Response
    # http://rubydoc.info/gems/faraday/0.7.4/Faraday/Response/Middleware
    # Faraday::Response::Middleware
    #
    # Instance methods
    #
    #   `#call` and `#on_complete`
    #
    # Methods inherited from Middleware:
    #
    #   `dependency`, `#initialize`, `loaded?`, `setup_parallel_manager`
    #
    class Middleware < Faraday::Response::Middleware
      # not actually doing anything yet but just in case we want to override anything
      # we can do that here
    end
  end
end
