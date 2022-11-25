require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) do
    User.new(
      name: 'Mateo Lane',
      photo: 'https://unsplash.com/photos/mateopic',
      bio: 'Comedian, Italian, Stylish, and part time youtuber',
      posts_counter: 5
    )
  end

  let(:post) do
    Post.new(
      author: user,
      title: 'My first post',
      text: 'This is my first post',
      comments_counter: 1,
      likes_counter: 1
    )
  end

  it 'is not valid without a title' do
    post.title = nil
    expect(post).to_not be_valid
  end

  it 'is valid with a title string' do
    post.title = 'My first post'
    expect(post).to be_valid
  end

  it 'is valid with a text string' do
    post.text = 'This is my first post'
    expect(post).to be_valid
  end

  it 'is only valid with a user' do
    post.author = user
    expect(post).to be_valid
  end

  it 'is not valid if comment counter is less than 0' do
    post.comments_counter = -1
    expect(post).to_not be_valid
  end

  it 'is valid if likes counter is 2' do
    post.likes_counter = 2
    expect(post).to be_valid
  end

  it 'updates posts counter after save' do
    post.save
    expect(user.posts_counter).to eq(6)
  end

  it 'check_last_five_comments should show the last five comments' do
    expect(subject.check_last_five_comments.length).to be_between(0, 5)
  end
end
