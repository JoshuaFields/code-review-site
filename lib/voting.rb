module Voting
  def send_vote(review_id, user_id, direction, opposite)
    unless REDIS.srem("review_#{direction}votes_#{review_id}", user_id)
      REDIS.sadd("review_#{direction}votes_#{review_id}", user_id)
      REDIS.srem("review_#{opposite}votes_#{review_id}", user_id)
    end

    REDIS.set(
      "review_score_#{review_id}", REDIS.scard("review_upvotes_#{review_id}") -
      REDIS.scard("review_downvotes_#{review_id}")
    )
  end
end
