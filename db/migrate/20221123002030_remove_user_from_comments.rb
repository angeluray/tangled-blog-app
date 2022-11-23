class RemoveUserFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_reference :comments, :user, null: false, foreign_key: true
  end
end
