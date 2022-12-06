class Post < ApplicationRecord
  has_many :likes, foreign_key: :post_id
  has_many :comments, foreign_key: :post_id
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  after_save :update_posts_counter

  validates :title, presence: true, length: { minimum: 3, maximum: 250 }
  validates :text, presence: true, length: { minimum: 3, maximum: 250 }
  validates :comments_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def check_last_five_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_posts_counter
    author.increment!(:posts_counter)
  end
end
