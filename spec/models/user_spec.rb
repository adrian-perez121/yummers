require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when creating a new user' do
    it 'is valid with all fields filled out correctly' do
      user = User.new(first_name: 'Foo', last_name: 'bar', email: 'foo@bar', password: '123456')
      expect(user).to be_valid
    end

    it 'is invalid with a short password' do
      user = User.new(first_name: 'Foo', last_name: 'bar', email: 'foo@bar', password: '123456')
      expect(user).to be_valid
    end

    it 'is invalid with a missing a first or last name' do
      user1 = User.new(last_name: 'bar', email: 'foo@bar', password: '123456')
      user2 = User.new(first_name: 'Foo', email: 'foo@bar', password: '123456')
      expect(user1).not_to be_valid
      expect(user2).not_to be_valid
    end

    it 'is invalid with a missing email' do
      user = User.new(first_name: 'Foo', last_name: 'bar', password: '123456')
      expect(user).not_to be_valid
    end
  end

  context 'when creating a user without an image' do
    it 'attaches the default image to the user' do
      user = User.create!(first_name: 'Foo', last_name: 'bar', email: 'foo@bar', password: '123456')
      expect(user.profile_photo).to be_attached
      expect(user.profile_photo.blob.filename).to eq('default_profile.jpg')
      user.destroy!
    end
  end

  describe '#liked? and #disliked?' do
    before(:each) do
      @user = User.create!(first_name: 'Foo', last_name: 'bar', email: 'foo@bar', password: '123456')
      @post = Post.create!(author_id: @user.id, recipe: '1234567890', description: '1234567890')
    end

    after(:each) do
      @post.destroy!
      @user.destroy!
    end
    it 'is liked when a user has liked a post' do
      like = Like.create!(user_id: @user.id, likeable_type: 'Post', likeable_id: @post.id)
      expect(@user).to be_liked(@post)
      like.destroy!
    end

    it 'is not liked when a user hasn\'t liked a post' do
      expect(@user).to_not be_liked(@post)
    end

    it 'is disliked when a user has disliked a post' do
      dislike = Dislike.create(user_id: @user.id, dislikeable_type: 'Post', dislikeable_id: @post.id)
      expect(@user).to be_disliked(@post)
      dislike.destroy!
    end

    it 'is not disliked when a user hasn\'t disliked a post' do
      expect(@user).to_not be_disliked(@post)
    end
  end
end
