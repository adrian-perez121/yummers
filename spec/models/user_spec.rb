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
end
