class AddUserToTutorial < ActiveRecord::Migration
  def change
    add_reference :tutorials, :user, index: true, foreign_key: true
  end
end
