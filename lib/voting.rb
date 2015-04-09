module Voting
  def send_upvote(review_id, user_id)
    unless REDIS.srem("review_upvotes_#{review_id}", user_id)
      REDIS.sadd("review_upvotes_#{review_id}", user_id)
      REDIS.srem("review_downvotes_#{review_id}", user_id)
    end

    REDIS.set(
      "review_score_#{review_id}", REDIS.scard("review_upvotes_#{review_id}") -
      REDIS.scard("review_downvotes_#{review_id}")
    )
  end

  def send_downvote(review_id, user_id)
    unless REDIS.srem("review_downvotes_#{review_id}", user_id)
      REDIS.sadd("review_downvotes_#{review_id}", user_id)
      REDIS.srem("review_upvotes_#{review_id}", user_id)
    end

    REDIS.set(
      "review_score_#{review_id}", REDIS.scard("review_upvotes_#{review_id}") -
      REDIS.scard("review_downvotes_#{review_id}")
    )
  end
end
