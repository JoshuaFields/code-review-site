class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.string :title, null: false
      t.string :body
      t.integer :tutorial_id, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
      t.integer :vote_tally, null: false, default: 0
    end
  end
end
