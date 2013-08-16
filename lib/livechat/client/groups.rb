module LiveChat
  class Client
    module Groups
      # @livechat.groups
      # @livechat.groups(123)
      def groups(*args)
        GroupsCollection.new(self, *args)
      end
    end

    class GroupsCollection < Collection
      def initialize(client, *args)
        super(client, :group, *args)
      end
    end
  end
end
