module LiveChat
  module REST
    class Agents < ListResource
      def initialize(path, client)
        super
        #hard-coded keys since agents are special
        @instance_id_key = 'login'
      end
    end

    class Agent < InstanceResource
      def reset_api_key
        raise "Can't execute without a REST Client" unless @client
        set_up_properties_from(@client.put("#{@path}/reset_api_key", {}))
        self
      end
    end
  end
end
