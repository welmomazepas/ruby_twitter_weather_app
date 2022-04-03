

class TwitterBot

    def initialize
        @twitter_client = Tweetkit::Client.new(
            bearer_token: ENV['TWITTER_TOKEN'], 
            consumer_key: ENV['TWITTER_API_KEY'], 
            consumer_secret: ENV['TWITTER_API_KEY_SECRET']
        )
    end

    def post_to_twitter(message)
        response = @twitter_client.tweet(message)
        return response.success?
    end

end