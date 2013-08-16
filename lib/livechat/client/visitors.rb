module Livechat
  class Client
    module Visitors
      # @livechat.visitors
      def visitors(*args)
        VisitorsCollection.new(self, *args)
      end
    end

    class VisitorsCollection < Collection
      def initialize(client, *args)
        super(client, :visitor, *args)
      end
    end
  end
end
