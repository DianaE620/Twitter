require 'pp'  
require 'nokogiri'
require 'open-uri'

class Twitter

  def initialize(url)
    @doc = Nokogiri::HTML(open(url))
  end

  def profile_name
    profile_name = @doc.search(".ProfileHeaderCard-name > a")
    profile_name.first.inner_text
    "User Name: #{profile_name.first.inner_text}"
  end

  def stats
    # Ingresando al numero de tweets
    tweets = @doc.search(".ProfileNav-stat.ProfileNav-stat--link.u-borderUserColor.u-textCenter.js-tooltip.js-nav > span.ProfileNav-value")
    tweets = tweets.inner_text
    # Ingresando a valores de stats
    valores = @doc.search(".ProfileNav-stat.ProfileNav-stat--link.u-borderUserColor.u-textCenter.js-tooltip.js-openSignupDialog.js-nonNavigable.u-textUserColor > span.ProfileNav-value")
    following = valores.first.inner_text
    # Ingresando al indice de followers
    followers = valores[1].inner_text
    # Ingresando al indice de likes
    likes = valores[2].inner_text
    "Stats: Tweets: #{tweets} Siguiendo: #{following} Seguidores: #{followers} Likes: #{likes}"
  end

  def ultimos_tweets
    tweets = @doc.search(".js-tweet-text-container > p.TweetTextSize.TweetTextSize--16px.js-tweet-text.tweet-text")

    for i in 0..7

      puts "----------------------------------------------------------------------------"
      p tweets[i].inner_text
     
      retweets = @doc.search(".stream-container > div.stream > ol.stream-items.js-navigable-stream > li:nth-child(#{i + 1}).js-stream-item.stream-item.stream-item.expanding-stream-item > div.tweet.js-stream-tweet.js-actionable-tweet.js-profile-popup-actionable.original-tweet.js-original-tweet > div.content > div.stream-item-footer > div.ProfileTweet-actionList.js-actions > div.ProfileTweet-action.ProfileTweet-action--retweet.js-toggleState.js-toggleRt > button.ProfileTweet-actionButton.js-actionButton.js-actionRetweet > div.IconTextContainer > span.ProfileTweet-actionCount > span.ProfileTweet-actionCountForPresentation").inner_text  
      favorites = @doc.search(".stream-container > div.stream > ol.stream-items.js-navigable-stream > li:nth-child(#{i + 1}).js-stream-item.stream-item.stream-item.expanding-stream-item > div.tweet.js-stream-tweet.js-actionable-tweet.js-profile-popup-actionable.original-tweet.js-original-tweet > div.content > div.stream-item-footer > div.ProfileTweet-actionList.js-actions > div.ProfileTweet-action.ProfileTweet-action--favorite.js-toggleState > button.ProfileTweet-actionButton.js-actionButton.js-actionFavorite > div.IconTextContainer > span.ProfileTweet-actionCount > span.ProfileTweet-actionCountForPresentation").inner_text
      puts "retweets: #{retweets}    favorites: #{favorites} "
      
    end
  end

  def twitter_board
    puts "----------------------------------------------------------------------------"
    puts profile_name
    puts "----------------------------------------------------------------------------"
    puts stats
    puts "----------------------------------------------------------------------------"
    puts "Tweets:"
    ultimos_tweets
  end

end
#html_file = open('https://twitter.com/El_Brody')

profile = Twitter.new('https://twitter.com/m4ur1c1o_')

profile.twitter_board


