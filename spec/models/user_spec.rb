require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      name: 'Mateo Lane',
      photo: 'https://unsplash.com/photos/mateopic',
      bio: 'Comedian, Italian, stylish, and part time youtuber',
      posts_counter: 5
    )
  end

  before { subject.save }

  it 'shows that name should be present ' do
    subject.name = 'Mateo Lane'
    expect(subject).to be_valid
  end

  it 'is not valid if name is not present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'shows that bio should be present ' do
    subject.bio = 'Comedian, Italian, stylish, and part time youtuber'
    expect(subject).to be_valid
  end

  it 'is not valid if bio is not present ' do
    subject.bio = nil
    expect(subject).to_not be_valid
  end

  it 'accepts the value if it is a string link' do
    subject.photo = 'https://unsplash.com/photos/mateopic'
    expect(subject).to be_valid
  end

  it 'accepts the value if it is a integer' do
    subject.posts_counter = 5
    expect(subject).to be_valid
  end

  it 'is not valid if posts_counter is a string' do
    subject.posts_counter = 'This is not a number'
    expect(subject).to_not be_valid
  end

  it 'check_last_three_posts should show the last 3 posts' do
    expect(subject.check_last_three_posts.length).to be_between(0, 3)
  end
end
