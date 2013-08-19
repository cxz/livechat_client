module LiveChat
  module REST
    class Goals < ListResource
    end

    class Goal < InstanceResource
      def mark_as_successful(*args)
        raise "Can't execute without a REST Client" unless @client
        @client.put "#{@path}/mark_as_successful", args
        self
      end
    end
  end
end
