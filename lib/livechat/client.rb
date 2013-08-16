require "livechat/collection"

module Livechat
  # Wrapper for the Livechat REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in {the Livechat API Documentation}.
  class Client < API
    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    require "livechat/client/agents"
    require "livechat/client/canned_responses"
    require "livechat/client/chats"
    require "livechat/client/goals"
    require "livechat/client/groups"
    require "livechat/client/reports"
    require "livechat/client/status"
    require "livechat/client/visitors"

    include Livechat::Client::Agents
    include Livechat::Client::CannedResponses
    include Livechat::Client::Chats
    include Livechat::Client::Goals
    include Livechat::Client::Groups
    include Livechat::Client::Reports
    include Livechat::Client::Status
    include Livechat::Client::Visitors
  end
end


