require '../rails_helper'

RSpec.describe 'Posts', type: :system, js: true do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'Mauricio', photo: 'https://ca.slack-edge.com/T47CT8XPG-U03RC6N92VB-af5eab93ad1a-512', bio: 'Micronaut', posts_counter: 0)
      @firstPost = Post.create(author: @user, title: 'Post number one', text: 'Post number one, this is the first one', likes_counter: 0, comments_counter: 0)
      @secondPost = Post.create(author: @user, title: 'Post number two', text: 'Post number two, it comes after number one', likes_counter: 0, comments_counter: 0)
      @thirdPost = Post.create(author: @user, title: 'Post number three', text: 'Post number three, it comes after number two', likes_counter: 0, comments_counter: 0)
      @fourthPost = Post.create(author: @user, title: 'Post number four', text: 'Post number four, it comes after number three', likes_counter: 0, comments_counter: 0)
      @firstComment = Comment.create(author: @user, post: @secondPost, text: 'Awesome post')
      @secondComment = Comment.create(author: @user, post: @secondPost, text: 'I like this post')
      @thirdComment = Comment.create(author: @user, post: @firstPost, text: 'What a great post')
      @fourthComment = Comment.create(author: @user, post: @firstPost, text: 'My favorite post')
      @fifthComment = Comment.create(author: @user, post: @firstPost, text: 'Cool post')

      visit user_posts_path(@user)
    end

    it "renders user's profile picture" do
      find("img[src='#{@user.photo}']")
    end

    it "renders the user's username" do
      expect(page).to have_content(@user.name)
    end

    it "renders the user's post count" do
      expect(page).to have_content(@user.posts_counter)
    end

    it "renders the user's posts" do
      expect(page).to have_content(@fourthPost.title)
      expect(page).to have_content(@secondPost.title)
      expect(page).to have_content(@thirdPost.title)
    end

    it "renders some of the post's body" do
      expect(page).to have_content(@fourthPost.text[0, 50])
      expect(page).to have_content(@secondPost.text[0, 50])
      expect(page).to have_content(@thirdPost.text[0, 50])
    end

    it 'renders first comments on a post' do
      expect(page).to have_content(@firstComment.text)
      expect(page).to have_content(@secondComment.text)
    end

    it 'renders comments count of a post' do
      expect(page).to have_content(@fourthPost.comments_counter)
      expect(page).to have_content(@secondPost.comments_counter)
      expect(page).to have_content(@thirdPost.comments_counter)
    end

    it 'renders likes count of a post' do
      expect(page).to have_content(@fourthPost.likes_counter)
      expect(page).to have_content(@secondPost.likes_counter)
      expect(page).to have_content(@thirdPost.likes_counter)
    end

    it "redirects to a specific post's show page" do
      click_link @secondPost.title
      expect(page).to have_current_path(user_post_path(@user, @secondPost))
    end
  end

  describe 'show page' do
    before(:example) do
      @user = User.create(name: 'Didier', photo: 'https://ca.slack-edge.com/T47CT8XPG-U03RBV0LTDK-ccb415d80fbf-512', bio: 'Awesome Dev', posts_counter: 0)
      @user2 = User.create(name: 'Mauricio', photo: 'https://ca.slack-edge.com/T47CT8XPG-U03RC6N92VB-af5eab93ad1a-512', bio: 'Micronaut', posts_counter: 0)
      @examplePost = Post.create(author: @user, title: 'Hello World', text: 'Programming is fun', likes_counter: 0, comments_counter: 0)
      @firstComment = Comment.create(author: @user, post: @examplePost, text: 'Great post')
      @secondComment = Comment.create(author: @user2, post: @examplePost, text: 'I don\'t like this post')
      @thirdComment = Comment.create(author: @user2, post: @examplePost, text: 'Could be better')

      visit user_post_path(@user, @examplePost)
    end

    it "renders the title" do
      expect(page).to have_content(@examplePost.title)
    end

    it "renders the author" do
      expect(page).to have_content(@user.name)
    end

    it 'renders comments count' do
      expect(page).to have_content(@examplePost.comments_counter)
    end

    it 'renders likes count' do
      expect(page).to have_content(@examplePost.likes_counter)
    end

    it "renders the body" do
      expect(page).to have_content(@examplePost.text)
    end

    it 'renders each commenter\'s username' do
      expect(page).to have_content(@user2.name)
      expect(page).to have_content(@user.name)
    end

    it 'renders all comments' do
      expect(page).to have_content(@firstComment.text)
      expect(page).to have_content(@secondComment.text)
      expect(page).to have_content(@thirdComment.text)
    end
  end
end