module LiveChat
  class Client
    module CannedResponses
      # @livechat.canned_responses                     - a list of cannned responses
      # @livechat.canned_responses(123)                          - the canned response with id=123
      def canned_response(*args)
        CannedResponsesCollection.new(self, *args)
      end
    end

    class CannedResponsesCollection < Collection
      def initialize(client, *args)
        super(client, :canned_response, *args)
      end
    end
  end
end
