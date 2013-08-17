module LiveChat
  class Client
    module Agents
      # @livechat.agents                               - a list of agents
      # @livechat.agents(john.doe@mycompany.com)       - the agent with id=123
      def agents(*args)
        AgentsCollection.new(self, *args)
      end
    end

    class AgentsCollection < Collection
      def initialize(client, *args)
        super(client, :agent, *args)
      end

      def reset_api_key
        self.put "#{@query[:path]}/reset_api_key"
      end
    end
  end
end
