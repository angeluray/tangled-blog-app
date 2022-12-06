require 'rails_helper'

RSpec.describe 'Show Index', type: :feature do
    before(:each) do
      @user = User.create(
        name: 'Mateo Lane',
        bio: 'Comedian',
        photo: 'https://yt3.ggpht.com/ytc/AMLnZu_8JpXVMXW_c2R2mlXD7t_ve-sWlPdXKWLKRpJp5A=s900-c-k-c0x00ffffff-no-rj',
        posts_counter: 0
      )
  
      @user1 = User.create(
        name: 'Angel Uray',
        bio: 'Software Engineer',
        photo: 'https://avatars.githubusercontent.com/u/97189760?v=4',
        posts_counter: 2
      )

      @post1 = Post.create(
        author_id: @user.id,
        title: 'First post',
        text: 'This is my first post',
        comments_counter: 1,
        likes_counter: 1
      )

      @post2 = Post.create(
        author_id: @user.id,
        title: 'Second post',
        text: 'This is my second post',
        comments_counter: 1,
        likes_counter: 1
      )

      @post3 = Post.create(
        author_id: @user.id,
        title: 'Third post',
        text: 'This is my third post',
        comments_counter: 1,
        likes_counter: 1
      )

      @post4 = Post.create(
        author_id: @user.id,
        title: 'Fourth post',
        text: 'This is my Fourth post',
        comments_counter: 1,
        likes_counter: 1
      )
    end

    describe 'Show path displays specific user info' do
        it 'displays the right username' do
            visit user_path(@user)
            expect(page).to have_content('Mateo Lane')
            expect(page).to_not have_content('Angel Uray')
        end

        it 'displays the users profile photo' do
            visit user_path(@user)
            expect(page).to have_css("img[src*='https://yt3.ggpht.com/ytc/AMLnZu_8JpXVMXW_c2R2mlXD7t_ve-sWlPdXKWLKRpJp5A=s900-c-k-c0x00ffffff-no-rj']")
        end

        it 'displays the right biography' do
            visit user_path(@user)
            expect(page).to have_content('Comedian')
            expect(page).to_not have_content('Software Engineer')
        end

        it 'displays the right biography in case we click second user' do
            visit user_path(@user1)
            expect(page).to have_content('Software Engineer')
            expect(page).to_not have_content('Comedian')
        end

        it 'displays the number of posts the user has written' do
            visit user_path(@user)
            expect(find('p.user-pcounter').text).to have_content('Number of post: 4')
            expect(find('p.user-pcounter').text).to_not have_content('Number of post: 5')
        end

        it 'displays the last 3 posts' do
            visit user_path(@user)
            expect(page).to have_content('Fourth post')
            expect(page).to have_content('Third post')
            expect(page).to have_content('Second post')
            expect(page).to_not have_content('First post')
        end

        it 'checks there is a See all posts button' do
            visit user_path(@user)
            expect(page).to have_content('See all posts')
        end

        it 'Redirects to the users posts index page if we click See all posts button' do
            visit user_path(@user)
            click_link 'See all posts'
            expect(page).to have_current_path(user_posts_path(@user))
        end

        it 'click a users post, it redirects to the posts show page' do
            visit user_path(@user)
            click_link 'Fourth post'
            expect(page).to have_current_path(user_post_path(@user, @post4))
        end
    end
end