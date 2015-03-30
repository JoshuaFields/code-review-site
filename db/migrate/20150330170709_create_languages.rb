class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :language_name, null: false
      t.string :wikipedia_url, null: false
      t.string :development_url
      t.timestamps null: false
    end
  end
end
