require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @u1 = User.create!(first_name: 'Foo', last_name: 'bar', email: 'foo@bar.com', password: '123456')
    @u2 = User.create!(first_name: 'Gar', last_name: 'play', email: 'gar@play.com', password: '123456')
    @c = Chat.create!(chatter_1_id: @u1.id, chatter_2_id: @u2.id)
  end

  after(:each) do
    @c.destroy!
    @u1.destroy!
    @u2.destroy!
  end

  describe "Validating a new message" do
    it "is valid when it has a message" do
      msg = Message.new(chat_id: @c.id, sender: @u1 ,message: "something")
      expect(msg).to be_valid
    end

    it "is not valid without a message" do
      msg = Message.new(chat_id: @c.id, sender: @u1)
      expect(msg).not_to be_valid
    end
  end
end
