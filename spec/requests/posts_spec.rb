require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before(:each) do
    @user = User.create(name: 'Mateo Lane', photo: 'https://unsplash.com/photos/mateopic',
                        bio: 'Comedian, Italian, stylish, and part time youtuber', posts_counter: 5)
    @post = Post.create(author: @user, title: 'My first post', text: 'This is my first post', comments_counter: 1,
                        likes_counter: 1)
  end

  describe "request list of all posts" do
    before(:each) { get user_posts_path(@user) }

    it "Gives the correct response status" do
      expect(response).to have_http_status(:ok)
    end

    it "Renders the correct template" do
      expect(response).to render_template('index')
    end

    it "Checks for post info into the body" do
      expect(response.body).to include("<h1>Full list of posts for a given user...</h1>")
    end
  end

  describe "Request only one post for a given user and post id" do
    before(:each) { get user_post_path(@user, @post) }

    it "Gives the correct response status" do
      expect(response).to have_http_status(:ok)
    end

    it "Renders the correct template succesfully" do
      expect(response).to render_template('show')
    end
  end
end
