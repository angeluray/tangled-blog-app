class RemoveUserFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_reference :posts, :user, null: false, foreign_key: true
  end
end
