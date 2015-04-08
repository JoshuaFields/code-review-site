module ScoreHelper
  def score(id)
    if Redis.current.exists("review_votes_#{id}")
      Redis.current.zcount("review_votes_#{id}", 1, 1) -
        Redis.current.zcount("review_votes_#{id}", -1, -1)
    else
      0
    end
  end
end
