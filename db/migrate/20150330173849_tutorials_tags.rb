class TutorialsTags < ActiveRecord::Migration
  def change
    create_table :tutorials_tags do |t|
      t.integer :tutorial_id, null: false
      t.integer :tag_id, null: false
    end
  end
end
