module LiveChat
  class Client
    module Visitors
      def visitors(*args)
        VisitorsCollection.new(self, *args)
      end
    end

    class VisitorsCollection < Collection
      def initialize(client, *args)
        super(client, :visitor, *args)
      end

      def chatting
        self.get "#{@query[:path]}/chatting"
      end

      def add_details(data={})
        yield data if block_given?
        create(data)
      end
    end
  end
end
