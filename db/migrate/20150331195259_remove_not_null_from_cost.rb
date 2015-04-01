class RemoveNotNullFromCost < ActiveRecord::Migration
  def up
    change_column :tutorials, :cost, :string, null: true
  end

  def down
    change_column :tutorials, :cost, :string, null: false
  end
end
