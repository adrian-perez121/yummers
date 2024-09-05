require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) do
    @user = User.create!(first_name: 'Foo', last_name: 'bar', email: 'foo@bar', password: '123456')
    @post = @user.posts.create!(recipe: '12345678910', description: '12345678910' )
    @comment = Comment.create!(author_id: @user.id, post_id: @post.id, body: '123456' )
  end
  after(:each) do
    @comment.destroy!
    @post.destroy!
    @user.destroy!
  end

  context 'when creating a like' do
    it 'is valid with a post and a comment' do
      like1 = @user.likes.build(likeable_type: 'Post', likeable_id: @post.id)
      like2 = @user.likes.build(likeable_type: 'Comment', likeable_id: @comment.id)
      expect(like1).to be_valid
      expect(like2).to be_valid
    end
  end
end
