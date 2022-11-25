require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) do
    User.new(
      name: 'Mateo Lane',
      photo: 'https://unsplash.com/photos/mateopic',
      bio: 'Comedian, Italian, Sylish, and part time youtuber',
      posts_counter: 6
    )
  end

  let(:post) do
    Post.new(
      author: user,
      title: 'My first post',
      text: 'This is my first post',
      comments_counter: 1,
      likes_counter: 2
    )
  end

  let(:comment) do
    Comment.new(
      author: user,
      post:,
      text: 'first comment'
    )
  end

  it 'is valid with a text' do
    comment.text = 'first comment'
    expect(comment).to be_valid
  end

  it 'is only valid with a user' do
    comment.author = user
    expect(comment).to be_valid
  end

  it 'is valid with a post' do
    comment.post = post
    expect(comment).to be_valid
  end

  it 'updates comments counter after save' do
    comment.save
    expect(post.comments_counter).to eq(2)
  end
end
