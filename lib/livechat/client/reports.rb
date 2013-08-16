module LiveChat
  class Client
    module Reports
      def reports(*args)
        ReportsCollection.new(self, *args)
      end
    end

    class ReportsCollection < Collection
      def initialize(client, *args)
        super(client, :report, *args)
      end


      #optional arguments:
      #  date_from – YYYY-MM-DD, defaults to the beginning of time.
      #  date_to – YYYY-MM-DD, defaults to today.
      #  group – id of the group, not set by default, returns statistics for the specified group.
      #  goal – id of the goal, not set by default.
      #  agent – agent's login, not set by default, return statistics for the specified agent.
      #  group_by – defaults to day (or hour when date_from equals date_to), can be set to month or hour.
      def goals(*args)
        @query[:path] += "/goals/#{URI.encode(args)}"
      end
    end
  end
end
