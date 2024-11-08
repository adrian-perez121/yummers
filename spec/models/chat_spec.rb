require 'rails_helper'

RSpec.describe Chat, type: :model do
  before(:each) do
    @u1 = User.create!(first_name: 'Foo', last_name: 'bar', email: 'foo@bar.com', password: '123456')
    @u2 = User.create!(first_name: 'Gar', last_name: 'play', email: 'gar@play.com', password: '123456')
  end

  after(:each) do
    @u1.destroy!
    @u2.destroy!
  end

  describe "Creating an association" do
    it "associates correctly" do
      chat = Chat.new(chatter_1_id: @u1.id, chatter_2_id: @u2.id)
      expect(chat.chatter_1).to eq(@u1)
      expect(chat.chatter_2).to eq(@u2)
    end
  end
end
