module LiveChat
  module REST
    class Status
      def initialize(path, client)
        @path, @client = path, client
      end

      def get(params={})
        @client.get "#{@path}/#{params[:group]}"
      end
    end
  end
end
