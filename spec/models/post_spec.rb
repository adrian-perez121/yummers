require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @u1 = User.create!(first_name: 'Foo', last_name: 'bar', email: 'foo@bar.com', password: '123456')
    @sample_text = 'eaw9fpj p9aujpaiofjpi jpa fjopajo pjapfj ap fjopa jopfjaopej poaejfeopajfopea'
  end
  after(:each) { @u1.destroy! }

  describe 'When validating a post on create' do
    it 'is valid when fields are filled out correctly' do
      post = @u1.posts.build(recipe: @sample_text, description: @sample_text)
      expect(post).to be_valid
    end

    it 'is not valid when there is no author_id' do
      post = Post.new(description: @sample_text, recipe: @sample_text)
      expect(post).to_not be_valid
    end

    it 'is not valid with a short description or recipe' do
      post1 = @u1.posts.build(description: 'hey', recipe: @sample_text)
      post2 = @u1.posts.build(description: @sample_text, recipe: 'hi')
      expect(post1).not_to be_valid
      expect(post2).not_to be_valid
    end

    it 'is not valid without a description or recipe' do
      post1 = @u1.posts.build(description: @sample_text)
      post2 = @u1.posts.build(recipe: @sample_text)
      expect(post1).to_not be_valid
      expect(post2).to_not be_valid
    end
  end
end
