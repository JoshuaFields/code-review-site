class CreateTutorialsTags < ActiveRecord::Migration
  def change
    create_table :tutorials_tags do |t|
      t.belongs_to :tutorial, index: true, foreign_key: true
      t.belongs_to :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
