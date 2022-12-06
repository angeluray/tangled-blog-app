require 'rails_helper'

RSpec.describe 'Post Index', type: :feature do
  before(:each) do
    @user = User.create(
        name: 'Angel Uray',
        bio: 'Software Engineer',
        photo: 'https://avatars.githubusercontent.com/u/97189760?v=4',
        posts_counter: 0
    )

    @post1 = Post.create(
      author_id: @user.id,
      title: 'First post',
      text: 'This is my first post',
      comments_counter: 0,
      likes_counter: 0
    )

    @post2 = Post.create(
      author_id: @user.id,
      title: 'Second post',
      text: 'This is my second post',
      comments_counter: 0,
      likes_counter: 0
    )

    # First post comments
    Comment.create(post_id: @post1.id, author_id: @user.id, text: 'My first comment omg')
    Comment.create(post_id: @post1.id, author_id: @user.id, text: 'I love this app you now')
    Comment.create(post_id: @post1.id, author_id: @user.id, text: 'Hahha I could do this all the time')
    Comment.create(post_id: @post1.id, author_id: @user.id, text: 'I wish I was a latino')
    Comment.create(post_id: @post1.id, author_id: @user.id, text: 'Guess what, I am')
    Comment.create(post_id: @post1.id, author_id: @user.id, text: 'Divine means Divino in Spanish')

    # Second post single comment
    Comment.create(post_id: @post2.id, author_id: @user.id, text: 'I am a single comment')

    # Likes for first post
    Like.create(post_id: @post1.id, author_id: @user.id)
    Like.create(post_id: @post1.id, author_id: @user.id)

    # Likes for second post
    Like.create(post_id: @post2.id, author_id: @user.id)
  end

  describe 'a post index page' do
    it 'displays the user name' do
      visit user_posts_path(@user)
      expect(page).to have_content('Angel Uray')
    end

    it 'displays the user photo' do
      visit user_posts_path(@user)
      expect(page).to have_css("img[src*='https://avatars.githubusercontent.com/u/97189760?v=4']")
    end

    it 'displays the number of posts' do
      visit user_posts_path(@user)
      expect(page).to have_content('Number of post: 2')
    end

    it 'checks for some body content INCLUDING Post\s titles' do
      visit user_posts_path(@user)

      # Post titles
      expect(page).to have_content('First post')
      expect(page).to have_content('Second post')

      expect(page).to have_content('This is my first post')
      expect(page).to have_content('This is my second post')
      expect(page).to have_css("div[class*='comments-section']")
      expect(page).to have_selector(:link_or_button, 'Add comment')
      expect(page).to have_selector(:link_or_button, 'Like post')
    end

    it 'displays number of likes and comments' do
      visit user_posts_path(@user)
      
      # First user post
      expect(page).to have_content('Likes counter:2')
      expect(page).to have_content('Comments counter:6')

      # Second user post
      expect(page).to have_content('Likes counter:1')
    end

    it 'displays the last 5 comments per post' do
      visit user_posts_path(@user)
      expect(page).to have_content('Divine means Divino in Spanish')
      expect(page).to have_content('Guess what, I am')
      expect(page).to have_content('I wish I was a latino')
      expect(page).to have_content('Hahha I could do this all the time')
      expect(page).to have_content('I love this app you now')
      expect(page).to_not have_content('My first comment omg')
    end

    it 'displays second\s post comment' do
      visit user_posts_path(@user)
      expect(page).to have_content('I am a single comment')
    end

    it 'redirects you to the specific post show view when is clicked' do
      visit user_posts_path(@user)
      click_link 'First post'
      expect(page).to have_current_path(user_post_path(@user, @post1))
    end

    it 'it me to a posts show page when the post is clicked' do
      visit user_posts_path(@user)
      click_link 'Second post'
      expect(page).to have_current_path(user_post_path(@user, @post2))
    end

    it 'checks that there is an Add a new post link' do
      visit user_posts_path(@user)
      expect(page).to have_link('Add a new post...')
    end

    it 'redirects to add new post path' do
      visit user_posts_path(@user)
      click_link 'Add a new post...'
      expect(page).to have_current_path(new_post_path)
    end
  end
end