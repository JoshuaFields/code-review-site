module Voting
  def send_upvote(review_id, user_id)
    if REDIS.zscore("review_votes_#{review_id}", user_id) == 1
      REDIS.zadd("review_votes_#{review_id}", 0, user_id)
    else
      REDIS.zadd("review_votes_#{review_id}", 1, user_id)
    end
  end

  def send_downvote(review_id, user_id)
    if REDIS.zscore("review_votes_#{review_id}", user_id) == -1
      REDIS.zadd("review_votes_#{review_id}", 0, user_id)
    else
      REDIS.zadd("review_votes_#{review_id}", -1, user_id)
    end
  end
end
