module LiveChat
  class Client
    module Status
      def status(*args)
        StatusCollection.new(self, *args)
      end
    end

    class StatusCollection < Collection
      def initialize(client, *args)
        super(client, :status, *args)
        fetch true
      end
    end
  end
end
