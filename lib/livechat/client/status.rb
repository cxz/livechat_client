module Livechat
  class Client
    module Status
      # @livechat.status
      def status(*args)
        StatusCollection.new(self, *args)
      end
    end

    class StatusCollection < Collection
      def initialize(client, *args)
        super(client, :status, *args)
      end
    end
  end
end
