module LiveChat
  class Client
    module Goals
      def goals(*args)
        GoalsCollection.new(self, *args)
      end
    end

    class GoalsCollection < Collection
      def initialize(client, *args)
        super(client, :goal, *args)
      end

      def mark_as_successful(*args)
        post("#{@query[:path]}/mark_as_successful", Hash[*args])
      end
    end
  end
end
