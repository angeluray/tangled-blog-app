RSpec.describe 'Post new', type: :feature do
    describe 'Post new shows form' do
        it 'displays a form' do
            visit new_post_path
            expect(page).to have_content('Share your thoughts by adding a new post')
            expect(page).to have_field("post[title]")
            expect(page).to have_field("post[text]")
            expect(page).to have_selector(:link_or_button, 'Submit Post')
        end
    end
end