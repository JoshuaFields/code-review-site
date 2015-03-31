class CreateTutorials < ActiveRecord::Migration
  def change
    create_table :tutorials do |t|
      t.string :title
      t.string :url
      t.string :language

      t.timestamps null: false
    end
  end
end
