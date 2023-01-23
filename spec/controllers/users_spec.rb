require '../rails_helper'

RSpec.describe UsersController, type: :controller do
    before :each do
        user = User.create(name: "John Doe", posts_counter: 0)
        post = user.posts.create(title: "Post 1", comments_counter: 0, likes_counter: 0)
        post.author_id = user.id
        post.save!
      end
  
    describe "GET /" do
      it "has a 200 status code" do
        get :index
        expect(response).to have_http_status(200)
      end
      it "renders the template" do
        get :index
        expect(response).to render_template(:index)
      end
    end
  
    describe "GET /users/:id" do
        let(:user) { User.create(name: "John Doe", posts_counter: 0) }
        it "has a 200 status code" do
          get :show, params: { id: user.id }
          expect(response).to have_http_status(200)
        end
        it "renders the template" do
            get :show, params: { id: user.id }
            expect(response).to render_template(:show)
        end
      end    
end