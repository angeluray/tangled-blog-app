require 'rails_helper'

RSpec.describe 'Post Show', type: :feature do
  before(:each) do
    @user = User.create(
        name: 'Tadessee Jemal',
        bio: 'Frontend Dev',
        photo: 'https://media-exp1.licdn.com/dms/image/C4D03AQFbtfe0TyWMCQ/profile-displayphoto-shrink_400_400/0/1664197502811?e=1674086400&v=beta&t=u9a1xs6lQXClOaKzYXwBLindXiieVlS-6NfmuZC_2cI',
        posts_counter: 0
    )

    @user1 = User.create(
      name: 'Angel Uray',
      bio: 'Backend Dev',
      photo: 'https://avatars.githubusercontent.com/u/97189760?v=4',
      posts_counter: 5
    )

    @post = Post.create(
      author_id: @user.id,
      title: 'First kawabonga',
      text: 'This is my first post',
      comments_counter: 0,
      likes_counter: 0
    )

    Comment.create(post_id: @post.id, author_id: @user.id, text: '*&%$#@ *crash* I am a robot lol')
    Comment.create(post_id: @post.id, author_id: @user.id, text: 'I am starving no matter when you read this')
    Comment.create(post_id: @post.id, author_id: @user1.id, text: 'You should eat a piece of cake buddy')
    Like.create(post_id: @post.id, author_id: @user1.id)

  end

  describe 'Displays the entire body comments counters, and title' do

    it 'displays the counters' do
      visit user_post_path(@user, @post)
      expect(page).to have_content('Comments counter:3')
      expect(page).to have_content('Likes counter:1')
    end

    it 'displays post title' do
      visit user_post_path(@user, @post)
      expect(page).to have_content('First kawabonga')
    end

    it 'displays post\s author as the title' do
      visit user_post_path(@user, @post)
      expect(page).to have_content('First kawabonga by Tadessee Jemal')
    end

    it 'displays the post\s text/content' do
      visit user_post_path(@user, @post)
      expect(page).to have_content('This is my first post')
    end

    it 'checks there is a comment section' do
        visit user_post_path(@user, @post)
        expect(page).to have_css("ul[class*='comments-section']")
        expect(page).to have_content('Comments')
    end

    it 'displays all comments with usernames' do
      visit user_post_path(@user, @post)
      expect(page).to have_content('Tadessee Jemal: *&%$#@ *crash* I am a robot lol')
      expect(page).to have_content('Tadessee Jemal: I am starving no matter when you read this')
      expect(page).to have_content('Angel Uray: You should eat a piece of cake buddy')
    end
  end
end