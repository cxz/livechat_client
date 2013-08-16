module Livechat
  module Authentication
    private

    # Authentication hash
    #
    # @return [Hash]
    def authentication
      {
        :consumer_key => consumer_key,
        :consumer_private => consumer_secret,
        :token => oauth_token,
        :token_secret => oauth_token_secret
      }
    end

    def authenticated?
      authentication.values.all?
    end
  end
end
