class AddColumnsToTutorials < ActiveRecord::Migration
  def up
    add_column :tutorials, :description, :text
    add_column :tutorials, :organization, :string, null: false
    add_column :tutorials, :cost, :string, null: false

    change_column :tutorials, :title, :string, null: false
    change_column :tutorials, :url, :string, null: false
    change_column :tutorials, :language, :string, null: false
  end

  def down
    remove_column :tutorials, :description
    remove_column :tutorials, :organization
    remove_column :tutorials, :cost

    change_column :tutorials, :title, :string, null: true
    change_column :tutorials, :url, :string, null: true
    change_column :tutorials, :language, :string, null: true
  end
end
