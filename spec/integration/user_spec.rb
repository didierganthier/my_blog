require '../rails_helper'

RSpec.describe 'Users', type: :system, js: true do
  describe 'first page' do
    before(:example) do
      @user = User.create(name: 'Didier', photo: 'https://didierganthier-homepage.vercel.app/images/profile.jpg', bio: 'Full-Stack Dev', posts_counter: 0)
      visit users_path
    end

    it 'renders the list of users' do
      expect(page).to have_content(@user.name)
    end

    it "renders user's profile picture" do
      find("img[src='#{@user.photo}']")
    end

    it 'renders the number of posts for each user' do
      expect(page).to have_content(@user.posts_counter)
    end

    it "redirects to the user's show page" do
      click_link @user.name
      expect(page).to have_current_path(user_path(@user))
    end
  end

  describe 'show page' do
    before(:example) do
      @user = User.create(name: 'Didier', photo: 'https://didierganthier-homepage.vercel.app/images/profile.jpg', bio: 'Awesome dev.', posts_counter: 0)
      @firstPost = Post.create(author: @user, title: 'Hello World', text: 'End of the world', likes_counter: 0, comments_counter: 0)
      @secondPost = Post.create(author: @user, title: 'Hello Moon', text: 'To the moon', likes_counter: 0, comments_counter: 0)
      @thirdPost = Post.create(author: @user, title: 'Wassup Jupiter', text: 'This is the biggest planet', likes_counter: 0, comments_counter: 0)
      visit user_path(@user)
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

    it "renders the user's bio" do
      expect(page).to have_content(@user.bio)
    end

    it "renders the user's last 3 posts" do
      expect(page).to have_content(@firstPost.title)
      expect(page).to have_content(@secondPost.title)
      expect(page).to have_content(@thirdPost.title)
    end

    it "redirects to user's postss page" do
      click_link @firstPost.title
      expect(page).to have_current_path(user_post_path(@user, @firstPost))
    end
  end
end
