require 'rails_helper'

describe PostsController do
  describe 'user access' do
    before :each do
      user = create(:user)
      sign_in user
    end

    describe 'GET #show' do
      #i don't get this example
      it 'assigns the requested Post to @post' do
        post = create(:post)
        get :show, id: post
        expect(assigns(:post)).to eq post
      end

      it 'renders the :show template' do
        post = create(:post)
        get :show, id: post
        expect(response).to render_template :show
      end
    end

    describe 'GET #index' do
      it 'populates an array with all posts' do
        post = create(:post)
        get :index
        expect(assigns(:posts)).to match_array([post])
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #new' do

      it 'assigns a new Post to @post' do
        get :new
        expect(assigns(:post)).to be_a_new(Post)
      end

      it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested Post to @post' do
        post = create(:post)
        get :edit, id: post
        expect(assigns(:post)).to eq post
      end

      it 'renders the :edit template' do
        post = create(:post)
        get :edit, id: post
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'saves the new post in the database' do
          expect {
            post :create, post: attributes_for(:post)
          }.to change(Post, :count).by(1)
        end

        it 'redirects to posts#show' do
          post :create, post: attributes_for(:post)
          expect(response).to redirect_to post_path(assigns(:post))
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new post in the database' do
          expect {
            post :create, post: attributes_for(:invalid_post)
            }.to_not change(Post, :count)
        end

        it 'rerenders the new post page' do
          post :create, post: attributes_for(:invalid_post)
          expect(response).to render_template :new
        end
      end
    end

    describe 'PUT #update' do
      before :each do
        @post = create(:post)
      end

      context 'valid attributes' do
        it "locates the requested @post" do
          patch :update, id: @post, post: attributes_for(:post)
          expect(assigns(:post)).to eq(@post)
        end

        it "changes @contact's attributes" do
          patch :update, id: @post, post: attributes_for(:post, title: 'New title', body: 'New body')
          @post.reload
          expect(@post.title).to eq('New title')
          expect(@post.body).to eq('New body')
        end

        it 'redirects to the updated contact' do
          patch :update, id: @post, post: attributes_for(:post)
          expect(response).to redirect_to @post
        end
      end

      context 'invalid attriibutes' do
        it "does not change the post's attributes" do
          patch :update, id: @post, post: attributes_for(:invalid_post)
          @post.reload
          expect(@post.title).to eq('This is a valid title')
          expect(@post.body).to eq('This is a valid body')
        end

        it 're-renders the edit template' do
          patch :update, id: @post, post: attributes_for(:invalid_post)
          expect(response).to render_template :edit
        end
      end

    end

    describe 'DELETE #destroy' do
      before :each do
        @post = create(:post)
      end

      it "deletes the contact" do
        expect {
          delete :destroy, id: @post
        }.to change(Post, :count).by(-1)
      end

      it "redirects to posts#index" do
        delete :destroy, id: @post
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'User not logged in' do
    describe 'GET #show' do
      #i don't get this example
      it 'assigns the requested Post to @post' do
        post = create(:post)
        get :show, id: post
        expect(assigns(:post)).to eq post
      end

      it 'renders the :show template' do
        post = create(:post)
        get :show, id: post
        expect(response).to render_template :show
      end
    end

    describe 'GET #index' do
      it 'populates an array with all posts' do
        post = create(:post)
        get :index
        expect(assigns(:posts)).to match_array([post])
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #new' do
      it 'requires login' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET #edit' do
      it 'requires login' do
        post = create(:post)
        get :edit, id: post
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, post: attributes_for(:post)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'PUT #update' do
      it 'requires login' do
        patch :update, id: create(:post), post: attributes_for(:post)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'DELETE #destroy' do
      it "requires login" do
        delete :destroy, id: create(:post)
        expect(response).to redirect_to new_user_session_path
      end
    end

  end
end