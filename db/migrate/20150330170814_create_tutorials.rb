class CreateTutorials < ActiveRecord::Migration
  def change
    create_table :tutorials do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :url, null: false
      t.string :organization
      t.string :cost

      t.timestamps null: false
    end
  end
end
