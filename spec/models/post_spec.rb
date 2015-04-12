require 'rails_helper'

describe 'Post' do
  it "is valid with a title and a body" do
    post = Post.new(
      title: 'This is a blog title',
      body: 'What a great blog.')
    expect(post).to be_valid
  end

  it "is invalid without a title" do
    post = Post.new(title: '')
    post.valid?
    expect(post.errors[:title]).to include("can't be blank")
  end

  it "is invalid with a title less than 5 char" do
    post = Post.new(title: 'a' * 4)
    post.valid?
    expect(post.errors[:title]).to include("is too short (minimum is 5 characters)")
  end

  it "is invalid without a body" do
    post = Post.new(body: '')
    post.valid?
    expect(post.errors[:body]).to include("can't be blank")
  end

end