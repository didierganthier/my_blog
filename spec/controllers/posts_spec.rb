require '../rails_helper'

RSpec.describe PostsController, type: :controller do
    # Check if it renders the correct template for the user's posts url
    describe "GET /users/:id/posts" do
        it "includes the text 'Posts'" do
          get user_posts_path(1)
          expect(response).to include("Posts")
        end
      end

        # Check if it renders the correct template for the user's post url
        describe "GET /users/:id/posts/:id" do
            it "includes the text 'Specific Post'" do
              get user_post_path(1, 1)
              expect(response).to include("Specific Post")
            end
          end

end