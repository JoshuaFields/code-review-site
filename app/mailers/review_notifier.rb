class ReviewNotifier < ActionMailer::Base
  default from: "review_notifications@example.com"
  def new_review(review)
    @review = review

    mail(
      to: review.tutorial.user.email,
      subject: "New Review for #{review.tutorial.title}"
    )
  end
end
