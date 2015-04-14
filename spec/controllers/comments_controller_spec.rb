require 'rails_helper'

describe CommentsController do

  describe 'POST #create' do
    context 'valid attributes' do
      before :each do
        @post = create(:post)
      end

      it 'saves the new comment in the database' do
        expect {
          post :create, post_id: @post.id, comment: attributes_for(:comment)
        }.to change(Comment, :count).by(1)
      end

      it 'redirect to the same post' do
        post :create, post_id: @post.id, comment: attributes_for(:comment)
        expect(response).to redirect_to @post
      end
    end

    context 'invalid attributes' do
      before :each do
        @post = create(:post)
      end

      it 'does not save the comment in the database' do
        expect {
          post :create, post_id: @post.id, comment: attributes_for(:comment, name: '')
        }.to_not change(Comment,:count)
      end

      it 'redirects to the same post' do
        post :create, post_id: @post.id, comment: attributes_for(:comment)
        expect(response).to redirect_to @post
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      # @post = create(:post)
      @comment = create(:comment)
    end

    #where does the extra post come from??
    it 'deletes the comment' do
      expect {
        delete :destroy, id: @comment, post_id: @comment.post_id
      }.to change(Comment,:count).by(-1)
    end

    it 'redirects to the same post' do
      delete :destroy, id: @comment, post_id: @comment.post_id
      expect(reponse).to redirect_to @post
    end
  end

end