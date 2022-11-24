class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments

  def check_last_three_posts
    posts.limit(3).order(created_at: :desc)
  end
end
