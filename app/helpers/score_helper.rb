module ScoreHelper
  def score(id)
    if REDIS.exists("review_votes_#{id}")
      REDIS.zcount("review_votes_#{id}", 1, 1) -
        REDIS.zcount("review_votes_#{id}", -1, -1)
    else
      0
    end
  end
end
