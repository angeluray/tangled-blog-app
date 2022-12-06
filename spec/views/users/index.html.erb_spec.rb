require 'rails_helper'

RSpec.describe 'User Index', type: :feature do
  before(:each) do
    @user = User.create(
      name: 'Mateo Lane',
      bio: 'Comedian',
      photo: 'https://yt3.ggpht.com/ytc/AMLnZu_8JpXVMXW_c2R2mlXD7t_ve-sWlPdXKWLKRpJp5A=s900-c-k-c0x00ffffff-no-rj',
      posts_counter: 1
    )

    @user2 = User.create(
      name: 'Angel Uray',
      bio: 'Software Engineer',
      photo: 'https://avatars.githubusercontent.com/u/97189760?v=4',
      posts_counter: 2
    )
  end

  describe 'users index page' do
    it 'displays the created users' do
      visit users_path
      expect(page).to have_content('Mateo Lane')
      expect(page).to have_content('Angel Uray')
    end

    it 'shows the right photo' do
      visit users_path
      expect(page).to have_css("img[src*='https://yt3.ggpht.com/ytc/AMLnZu_8JpXVMXW_c2R2mlXD7t_ve-sWlPdXKWLKRpJp5A=s900-c-k-c0x00ffffff-no-rj']")
      expect(page).to have_css("img[src*='https://avatars.githubusercontent.com/u/97189760?v=4']")
    end

    it 'displays the right Number of posts' do
      visit users_path
      expect(page).to have_content('Number of Posts: 1')
      expect(page).to have_content('Number of Posts: 2')
    end

    it 'displays a info of a selected user when is redirected to show path' do
      visit users_path
      click_link 'Angel Uray'
      expect(page).to have_content('Software Engineer')
      expect(page).to_not have_content('Comedian')
    end
  end
end