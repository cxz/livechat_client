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

      #http://developers.livechatinc.com/rest-api/#get-dashboard-data
      def dashboard(*arg)
        if arg.is_a?(Hash) and arg.has_key? :agent
          dashboard_agent arg[:agent]

        elsif arg.is_a?(Hash) and arg.has_key? :group
          dashboard_group arg[:group]

        else
          @query[:path] += '/dashboards'
          fetch true
        end
      end

      #http://developers.livechatinc.com/rest-api/#get-dashboard-data-for-agent
      def dashboard_agent(login)
        @query[:path] += "/agent/#{login}"
        fetch true
      end

      #http://developers.livechatinc.com/rest-api/#get-dashboard-data-for-group
      def dashboard_group(group_id)
        @query[:path] += "/group/#{group_id}"
        fetch true
      end

      #http://developers.livechatinc.com/rest-api/#get-chats-report
      #optional arguments:
      # date_from – YYYY-MM-DD, defaults to the beginning of time.
      # date_to – YYYY-MM-DD, defaults to today.
      # group – id of the group, not set by default, returns statistics for the specified group.
      # agent – agent's login, not set by default, return statistics for the specified agent.
      # group_by – defaults to day (or hour when date_from equals date_to), can be set to month or hour.
      def chats(*args)
        @query[:path] += '/chats'
        @query.merge! Hash[*args]
        fetch true
      end

      #http://developers.livechatinc.com/rest-api/#get-ratings-report
      #optional arguments
      # date_from – YYYY-MM-DD, defaults to the beginning of time.
      # date_to – YYYY-MM-DD, defaults to today.
      # group – id of the group, not set by default, returns statistics for the specified group.
      # agent – agent's login, not set by default, return statistics for the specified agent.
      # group_by – defaults to day (or hour when date_from equals date_to), can be set to month or hour.
      def ratings(*args)
        @query[:path] += '/ratings'
        @query.merge! Hash[*args]
        fetch true
      end

      #http://developers.livechatinc.com/rest-api/#get-ratings-ranking
      #optional arguments
      # date_from – YYYY-MM-DD, defaults to the beginning of time.
      # date_to – YYYY-MM-DD, defaults to today.
      # group – id of the group, not set by default, returns statistics for the specified group.
      def ratings_ranking(*args)
        @query[:path] += '/ratings/ranking'
        @query.merge! Hash[*args]
        fetch true
      end

      #http://developers.livechatinc.com/rest-api/#get-queued-visitors-report
      #optional arguments
      # date_from – YYYY-MM-DD, defaults to the beginning of time.
      # date_to – YYYY-MM-DD, defaults to today.
      # group – id of the group, not set by default, returns statistics for the specified group.
      # group_by – defaults to day (or hour when date_from equals date_to), can be set to month or hour.
      def queued_visitors(*args)
        @query[:path] += '/queued_visitors'
        @query.merge! Hash[*args]
        fetch true
      end

      #http://developers.livechatinc.com/rest-api/#get-queue-waiting-times-report
      #optional arguments
      # date_from – YYYY-MM-DD, defaults to the beginning of time.
      # date_to – YYYY-MM-DD, defaults to today.
      # group – id of the group, not set by default, returns statistics for the specified group.
      # group_by – defaults to day (or hour when date_from equals date_to), can be set to month or hour.
      def queued_visitors_waiting_times(*args)
        @query[:path] += '/queued_visitors_waiting_times'
        @query.merge! Hash[*args]
        fetch true
      end

      #http://developers.livechatinc.com/rest-api/#get-availability-report
      #optional arguments
      # date_from – YYYY-MM-DD, defaults to the beginning of time.
      # date_to – YYYY-MM-DD, defaults to today.
      # group – id of the group, not set by default, returns statistics for the specified group.
      # agent – agent's login, not set by default, return statistics for the specified agent.
      def availability
        @query[:path] += '/availability'
        @query.merge! Hash[*args]
        fetch true
      end

      #http://developers.livechatinc.com/rest-api/#get-chatting-time-report
      #optional arguments
      # date_from – YYYY-MM-DD, defaults to the beginning of time.
      # date_to – YYYY-MM-DD, defaults to today.
      # group – id of the group, not set by default, returns statistics for the specified group.
      # agent – agent's login, not set by default, returns statistics for the specified agent
      def chatting_time
        @query[:path] += '/chatting_time'
        @query.merge! Hash[*args]
        fetch true
      end

      #http://developers.livechatinc.com/rest-api/#get-goals-report
      #optional arguments:
      #  date_from – YYYY-MM-DD, defaults to the beginning of time.
      #  date_to – YYYY-MM-DD, defaults to today.
      #  group – id of the group, not set by default, returns statistics for the specified group.
      #  goal – id of the goal, not set by default.
      #  agent – agent's login, not set by default, return statistics for the specified agent.
      #  group_by – defaults to day (or hour when date_from equals date_to), can be set to month or hour.
      def goals(*args)
        @query[:path] += '/goals'
        @query.merge! Hash[*args]
        fetch true
      end

    end

  end
end
