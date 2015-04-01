class ChangeColumnNullToTutorial < ActiveRecord::Migration
  def change
    change_column_null(:tutorials, :organization, true)
  end
end
