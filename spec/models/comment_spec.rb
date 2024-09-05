require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'when creating a new comment' do
    before(:each) do
      @user = User.create!(first_name: 'Foo', last_name: 'bar', email: 'foo@bar', password: '123456')
      @post = @user.posts.create!(description: 'woah im a description', recipe: 'wow im a recipe, so true' )
    end
    after(:each) do
      @user.destroy!
      @post.destroy!
    end

    it 'is valid with the proper fields filled out ideally' do
      comment = Comment.new(author_id: @user.id, post_id: @post.id, body: '123456' )
      expect(comment).to be_valid
    end

    it 'is valid with proper fields filled out ideally and a comment association' do
      comment1 = Comment.create!(author_id: @user.id, post_id: @post.id, body: '123456' )
      comment2 = Comment.new(author_id: @user.id, post_id: @post.id, body: '1234567', comment_id: comment1.id )
      expect(comment2).to be_valid
      comment1.destroy!
    end

    it 'is not valid without an author' do
      comment = Comment.new( post_id: @post.id, body: '123456' )
      expect(comment).to_not be_valid
    end

    it 'is not valid without a post' do
      comment = Comment.new(author_id: @user.id, body: '123456' )
      expect(comment).to_not be_valid
    end

    it 'is not valid bodies that are too small or too big' do
      comment1 = Comment.new(author_id: @user.id, post_id: @post.id, body: '1' )
      comment2 = Comment.new(author_id: @user.id, post_id: @post.id,
                             body: 'kafepijfiapjekafepijfiapjekafepijfiapjekafepijfiapjekafepijfiapjekafepijfiapjekafepijfiapj
                                    ekafepijfiapjekafepijfiapjekafepijfiapjekafepijfiapjekafepijfiapjekafepijfiapjekafepijfiapjekafepijfiapjekafepijf
                                    iapjekafepijfiapje fiapjekafepijfiapjekafepijfiapjekafepijfiapjekafepijfiapjekafepijfiapjekafepijfiapjekafepijfia
                                     pjekafepijfiapjekafepijfiapjekafepijfiapjekafepijfiapje' )
      [comment1, comment2].each { |comment| expect(comment).not_to be_valid }
    end
  end
end
