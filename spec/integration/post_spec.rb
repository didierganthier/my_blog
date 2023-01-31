require '../rails_helper'

RSpec.describe 'Posts', type: :system, js: true do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'Mauricio', photo: 'https://ca.slack-edge.com/T47CT8XPG-U03RC6N92VB-af5eab93ad1a-512',
                          bio: 'Micronaut', posts_counter: 0)
      @first_post = Post.create(author: @user, title: 'Post number one', text: 'Post number one, this is the first one',
                                likes_counter: 0, comments_counter: 0)
      @second_post = Post.create(author: @user, title: 'Post number two',
                                 text: 'Second post', likes_counter: 0, comments_counter: 0)
      @third_post = Post.create(author: @user, title: 'Post number three',
                                text: 'Third post', likes_counter: 0, comments_counter: 0)
      @fourth_post = Post.create(author: @user, title: 'Post number four',
                                 text: 'Fourth post', likes_counter: 0, comments_counter: 0)
      @first_comment = Comment.create(author: @user, post: @second_post, text: 'Awesome post')
      @second_comment = Comment.create(author: @user, post: @second_post, text: 'I like this post')
      @third_comment = Comment.create(author: @user, post: @first_post, text: 'What a great post')
      @fourth_comment = Comment.create(author: @user, post: @first_post, text: 'My favorite post')
      @fifth_comment = Comment.create(author: @user, post: @first_post, text: 'Cool post')

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
      expect(page).to have_content(@fourth_post.title)
      expect(page).to have_content(@second_post.title)
      expect(page).to have_content(@third_post.title)
    end

    it "renders some of the post's body" do
      expect(page).to have_content(@fourth_post.text[0, 50])
      expect(page).to have_content(@second_post.text[0, 50])
      expect(page).to have_content(@third_post.text[0, 50])
    end

    it 'renders first comments on a post' do
      expect(page).to have_content(@first_comment.text)
      expect(page).to have_content(@second_comment.text)
    end

    it 'renders comments count of a post' do
      expect(page).to have_content(@fourth_post.comments_counter)
      expect(page).to have_content(@second_post.comments_counter)
      expect(page).to have_content(@third_post.comments_counter)
    end

    it 'renders likes count of a post' do
      expect(page).to have_content(@fourth_post.likes_counter)
      expect(page).to have_content(@second_post.likes_counter)
      expect(page).to have_content(@third_post.likes_counter)
    end

    it "redirects to a specific post's show page" do
      click_link @second_post.title
      expect(page).to have_current_path(user_post_path(@user, @second_post))
    end
  end

  describe 'show page' do
    before(:example) do
      @user = User.create(name: 'Didier', photo: 'https://ca.slack-edge.com/T47CT8XPG-U03RBV0LTDK-ccb415d80fbf-512',
                          bio: 'Awesome Dev', posts_counter: 0)
      @second_user = User.create(name: 'Mauricio', photo: 'https://ca.slack-edge.com/T47CT8XPG-U03RC6N92VB-af5eab93ad1a-512',
                                 bio: 'Micronaut', posts_counter: 0)
      @example_post = Post.create(author: @user, title: 'Hello World', text: 'Programming is fun', likes_counter: 0,
                                  comments_counter: 0)
      @first_comment = Comment.create(author: @user, post: @example_post, text: 'Great post')
      @second_comment = Comment.create(author: @second_user, post: @example_post, text: 'I don\'t like this post')
      @third_comment = Comment.create(author: @second_user, post: @example_post, text: 'Could be better')

      visit user_post_path(@user, @example_post)
    end

    it 'renders the title' do
      expect(page).to have_content(@example_post.title)
    end

    it 'renders the author' do
      expect(page).to have_content(@user.name)
    end

    it 'renders comments count' do
      expect(page).to have_content(@example_post.comments_counter)
    end

    it 'renders likes count' do
      expect(page).to have_content(@example_post.likes_counter)
    end

    it 'renders the body' do
      expect(page).to have_content(@example_post.text)
    end

    it 'renders each commenter\'s username' do
      expect(page).to have_content(@second_user.name)
      expect(page).to have_content(@user.name)
    end

    it 'renders all comments' do
      expect(page).to have_content(@first_comment.text)
      expect(page).to have_content(@second_comment.text)
      expect(page).to have_content(@third_comment.text)
    end
  end
end
