module Livechat
  class Client
    module Agents
      # @livechat.agents                               - a list of agents
      # @livechat.agents(123)                          - the agent with id=123
      def agents(*args)
        AgentsCollection.new(self, *args)
      end
    end

    class AgentsCollection < Collection
      def initialize(client, *args)
        super(client, :agent, *args)
      end
    end
  end
end
