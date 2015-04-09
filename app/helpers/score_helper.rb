module ScoreHelper
  def score(id)
    REDIS.get("review_score_#{id}") || "0"
  end
end
