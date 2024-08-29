require 'rails_helper'

RSpec.describe "Posts", type: :request do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create!(first_name: 'Foo', last_name: 'bar', email: 'foo@bar', password: '123456')
    @valid_attributes = {description: 'eaw9fpj p9aujpaiofjpi jpa fjopajo pjapfj ap fjopa jopfjaopej floppa',
                         recipe: 'eaw9fpj p9aujpaiofjpi jpa fjopajo pjapfj ap fjopa jopfjaopej floppa' }
    @invalid_attributes = {description: '',
                           recipe: ''}
    sign_in @user
  end

  after(:each) do
    sign_out @user
    @user.destroy!
  end

  describe 'POST #create' do
    context 'with valid arguments' do
      it 'creates a new post' do
        expect {
          post "/users/#{@user.id}/posts", params: { user_id: @user.id, post: @valid_attributes}
        }.to change(Post, :count).by(1)
        created_post = Post.last
        created_post.destroy!
      end
    end
  end
end
