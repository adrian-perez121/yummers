require 'rails_helper'

RSpec.describe Dislike, type: :model do
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

  context 'when creating a dislike' do
    it 'is valid with a post and a coment' do
      dislike1 = @user.dislikes.build(dislikeable_type: 'Post', dislikeable_id: @post.id)
      dislike2 = @user.dislikes.build(dislikeable_type: 'Comment', dislikeable_id: @comment.id)
      expect(dislike1).to be_valid
      expect(dislike2).to be_valid
    end
  end

end
