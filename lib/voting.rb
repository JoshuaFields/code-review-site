module Voting
  def send_upvote(review_id, user_id)
    if Redis.current.zscore("review_votes_#{review_id}", user_id) == 1
      Redis.current.zadd("review_votes_#{review_id}", 0, user_id)
    else
      Redis.current.zadd("review_votes_#{review_id}", 1, user_id)
    end
  end

  def send_downvote(review_id, user_id)
    if Redis.current.zscore("review_votes_#{review_id}", user_id) == -1
      Redis.current.zadd("review_votes_#{review_id}", 0, user_id)
    else
      Redis.current.zadd("review_votes_#{review_id}", -1, user_id)
    end
  end
end
