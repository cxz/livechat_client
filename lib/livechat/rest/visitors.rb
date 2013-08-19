module LiveChat
  module REST
    class Visitors < ListResource
      def chatting
        list
      end
    end

    class Visitor < InstanceResource
      def add_details(params={})
        yield params if block_given?
        @client.post(@path, params)
        self
      end
    end
  end
end
