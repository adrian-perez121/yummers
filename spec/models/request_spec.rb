require 'rails_helper'

RSpec.describe Request, type: :model do
  describe '#can_request' do
    before(:each) do
      @u1 = User.create!(first_name: 'Foo', last_name: 'bar', email:'foo@bar', password: '123456')
      @u2 = User.create!(first_name: 'John', last_name: 'Doe', email: 'john@doe', password: '123456')
    end
    after(:each) do
      @u1.destroy
      @u2.destroy
    end

    it 'allows two users to request eachother if there is not an already existing request' do
      expect(Request).to be_can_request(@u1, @u2)
      expect(Request).to be_can_request(@u2, @u1)
    end

    it "doesn't let users request themselves" do
      expect(Request).to_not be_can_request(@u1, @u1)
    end

    it "doesn't allow another request if one already exists" do
      request = Request.create!(requester_id: @u1.id, requested_id: @u2.id )
      expect(Request).to_not be_can_request(@u1, @u2)
      request.destroy
    end
  end
end
