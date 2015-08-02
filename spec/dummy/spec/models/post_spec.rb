require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of :client_id }
  it { should validate_presence_of :title }

  describe 'default scope' do
    it 'scopes new posts to the current client' do
      MultiClient::Client.current_id = FactoryGirl.create(:multi_client_client).id

      expect(Post.new.client_id).to eq(MultiClient::Client.current_id)
    end

    it 'scopes exiting posts to the correct client' do
      @first_client  = FactoryGirl.create(:multi_client_client, identifier: 'first').id
      @second_client = FactoryGirl.create(:multi_client_client, identifier: 'second').id

      MultiClient::Client.current_id = @first_client
      @post_for_first_client = Post.create!(title: 'Post for first client')

      MultiClient::Client.current_id = @second_client
      @post_for_second_client = Post.create!(title: 'Post for second client')

      MultiClient::Client.current_id = @first_client
      expect(Post.all).to eq([@post_for_first_client])
    end
  end

  describe 'self.unscoped' do
    # it 'raises an exception' do
    #   expect {
    #     Post.unscoped
    #   }.to raise_error(UnscopedForbiddenError)
    # end
  end
end
