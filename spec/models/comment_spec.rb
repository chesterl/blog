require 'rails_helper'

describe 'Comment' do

  it "is a valid comment with a name and a body" do
    expect(build(:comment)).to be_valid
  end

  it "is invalid without a name" do
    comment = build(:comment, name: '')
    comment.valid?
    expect(comment.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a body" do
    comment = build(:comment, body: '')
    comment.valid?
    expect(comment.errors[:body]).to include("can't be blank")
  end

  #need to implement
  it 'should destroy all commments when a post is destroyed' do
    post = create(:post)
    comment = create(:comment)
    binding.pry
  end

end
