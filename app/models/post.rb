class Post < ApplicationRecord
  has_many :likes
  has_many :comments
  belongs_to :user, foreign_key: true
  after_save :update_posts_counter

  def check_last_five_posts
    comments.last(5)
  end

  private

  def update_posts_counter
    user.update(posts_counter: user.posts.length)
  end
end
