require './rails_helper'


RSpec.describe User, type: :model do
    subject { User.new(name: 'John Doe') }

    before { subject.save }

    it 'title should be present' do
        subject.name = nil
        expect(subject).to_not be_valid
    end

    it 'posts counter should be present' do
        subject.posts_counter = nil
        expect(subject).to_not be_valid
    end

    it 'posts counter should be greater than or equal to 0' do
        subject.posts_counter = -1
        expect(subject).to_not be_valid
    end    
end
