class AddNullConstraintToReviewRating < ActiveRecord::Migration
  def change
    change_column_null(:reviews, :rating, false)
  end
end
