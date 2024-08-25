require 'rails_helper'

RSpec.describe Following, type: :model do
  before(:each) do
    @u1 = User.create!(first_name: 'Foo', last_name: 'bar', email:'foo@bar', password: '123456')
    @u2 = User.create!(first_name: 'John', last_name: 'Doe', email: 'john@doe', password: '123456')
  end
  after(:each) do
    @u1.destroy
    @u2.destroy
  end

  describe 'Creating a new following' do
    it 'is valid with two different users' do
      f = Following.new(followee_id: @u1.id, follower_id: @u2.id)
      expect(f).to be_valid
    end

    it 'is not valid with the same user' do
      f = Following.new(follower_id: @u1.id, followee_id: @u1.id)
      expect(f).to_not be_valid
    end
  end
end
