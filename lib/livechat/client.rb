require "livechat/collection"

module LiveChat
  # Wrapper for the LiveChat REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in {the LiveChat API Documentation}.
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

    include LiveChat::Client::Agents
    include LiveChat::Client::CannedResponses
    include LiveChat::Client::Chats
    include LiveChat::Client::Goals
    include LiveChat::Client::Groups
    include LiveChat::Client::Reports
    include LiveChat::Client::Status
    include LiveChat::Client::Visitors
  end
end


