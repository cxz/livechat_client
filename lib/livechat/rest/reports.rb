module LiveChat
  module REST
    class Reports < ListResource

      #http://developers.livechatinc.com/rest-api/#get-dashboard-data
      def dashboard(*arg)
        if arg.is_a?(Hash) and arg.has_key? :agent
          dashboard_agent arg[:agent]

        elsif arg.is_a?(Hash) and arg.has_key? :group
          dashboard_group arg[:group]

        else
          @client.get "#{@path}/dashboards"
        end
      end

      #http://developers.livechatinc.com/rest-api/#get-dashboard-data-for-agent
      def dashboard_agent(login)
        @client.get "#{@path}/agent/#{login}"
      end

      #http://developers.livechatinc.com/rest-api/#get-dashboard-data-for-group
      def dashboard_group(group_id)
        @client.get "#{@path}/group/#{group_id}"
      end

      #http://developers.livechatinc.com/rest-api/#get-chats-report
      #optional arguments:
      # date_from – YYYY-MM-DD, defaults to the beginning of time.
      # date_to – YYYY-MM-DD, defaults to today.
      # group – id of the group, not set by default, returns statistics for the specified group.
      # agent – agent's login, not set by default, return statistics for the specified agent.
      # group_by – defaults to day (or hour when date_from equals date_to), can be set to month or hour.
      def chats(*args)
        @client.get "#{@path}/chats", Hash[*args]
      end

      #http://developers.livechatinc.com/rest-api/#get-ratings-report
      #optional arguments
      # date_from – YYYY-MM-DD, defaults to the beginning of time.
      # date_to – YYYY-MM-DD, defaults to today.
      # group – id of the group, not set by default, returns statistics for the specified group.
      # agent – agent's login, not set by default, return statistics for the specified agent.
      # group_by – defaults to day (or hour when date_from equals date_to), can be set to month or hour.
      def ratings(*args)
        @client.get "#{@path}/ratings", Hash[*args]
      end

      #http://developers.livechatinc.com/rest-api/#get-ratings-ranking
      #optional arguments
      # date_from – YYYY-MM-DD, defaults to the beginning of time.
      # date_to – YYYY-MM-DD, defaults to today.
      # group – id of the group, not set by default, returns statistics for the specified group.
      def ratings_ranking(*args)
        @client.get "#{@path}/ratings/ranking", Hash[*args]
      end

      #http://developers.livechatinc.com/rest-api/#get-queued-visitors-report
      #optional arguments
      # date_from – YYYY-MM-DD, defaults to the beginning of time.
      # date_to – YYYY-MM-DD, defaults to today.
      # group – id of the group, not set by default, returns statistics for the specified group.
      # group_by – defaults to day (or hour when date_from equals date_to), can be set to month or hour.
      def queued_visitors(*args)
        @client.get "#{@path}/queued_visitors", Hash[*args]
      end

      #http://developers.livechatinc.com/rest-api/#get-queue-waiting-times-report
      #optional arguments
      # date_from – YYYY-MM-DD, defaults to the beginning of time.
      # date_to – YYYY-MM-DD, defaults to today.
      # group – id of the group, not set by default, returns statistics for the specified group.
      # group_by – defaults to day (or hour when date_from equals date_to), can be set to month or hour.
      def queued_visitors_waiting_times(*args)
        @client.get "#{@path}/queued_visitors_waiting_times", Hash[*args]
      end

      #http://developers.livechatinc.com/rest-api/#get-availability-report
      #optional arguments
      # date_from – YYYY-MM-DD, defaults to the beginning of time.
      # date_to – YYYY-MM-DD, defaults to today.
      # group – id of the group, not set by default, returns statistics for the specified group.
      # agent – agent's login, not set by default, return statistics for the specified agent.
      def availability(*args)
        @client.get "#{@path}/availability", Hash[*args]
      end

      #http://developers.livechatinc.com/rest-api/#get-chatting-time-report
      #optional arguments
      # date_from – YYYY-MM-DD, defaults to the beginning of time.
      # date_to – YYYY-MM-DD, defaults to today.
      # group – id of the group, not set by default, returns statistics for the specified group.
      # agent – agent's login, not set by default, returns statistics for the specified agent
      def chatting_time(*args)
        @client.get "#{@path}/chatting_time", Hash[*args]
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
        @client.get "#{@path}/goals", Hash[*args]
      end

    end

    class Report < InstanceResource
    end
  end
end
