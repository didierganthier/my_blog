require './rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John Doe', posts_counter: 0) }

  before { subject.save }

  it 'title should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'title should be John Doe' do
    expect(subject.name).to eq('John Doe')
  end

  it 'posts counter should be present' do
    subject.posts_counter = nil
    expect(subject).to_not be_valid
  end

  it 'posts counter should be greater than or equal to 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should return the 3 most recent posts for a given user' do
    user = User.create(name: 'John Doe', posts_counter: 3)
    5.times do |i|
      post = user.posts.build(title: "Post #{i}", comments_counter: 0, likes_counter: 0)
      post.author_id = user.id
      post.save
    end
    expect(user.recent_posts.length).to eq(3)
  end
end
