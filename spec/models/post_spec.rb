require 'rails_helper'

describe 'Post' do
  it "is valid with a title and a body" do
    expect(FactoryGirl.build(:post)).to be_valid
  end

  it "is invalid without a title" do
    post = FactoryGirl.build(:post, title: '')
    post.valid?
    expect(post.errors[:title]).to include("can't be blank")
  end

  it "is invalid with a title less than 5 char" do
    post = FactoryGirl.build(:post, title: 'a' * 4)
    post.valid?
    expect(post.errors[:title]).to include("is too short (minimum is 5 characters)")
  end

  it "is invalid without a body" do
    post = FactoryGirl.build(:post, body: '')
    post.valid?
    expect(post.errors[:body]).to include("can't be blank")
  end

end