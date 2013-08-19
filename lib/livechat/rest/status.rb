module LiveChat
  module REST
    class Status
      def initialize(path, client)
        @path, @client = path, client
      end

      def get(group)
        @client.get "#{@path}/#{group}"
      end
    end
  end
end
