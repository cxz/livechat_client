module LiveChat
  class Client
    module Chats
      def chats(*args)
        ChatsCollection.new(self, *args)
      end
    end

    class ChatsCollection < Collection
      def initialize(client, *args)
        super(client, :chat, *args)
      end
    end
  end
end
