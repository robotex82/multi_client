require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of :tenant_id }
  it { should validate_presence_of :title }

  describe 'default scope' do
    it 'scopes new posts to the current tenant' do
      MultiClient::Client.current_id = FactoryGirl.create(:multi_client_client).id

      expect(Post.new.tenant_id).to eq(MultiClient::Client.current_id)
    end

    it 'scopes exiting posts to the correct tenant' do
      @first_tenant  = FactoryGirl.create(:tenant, identifier: 'first').id
      @second_tenant = FactoryGirl.create(:tenant, identifier: 'second').id

      MultiClient::Client.current_id = @first_tenant
      @post_for_first_tenant = Post.create!(title: 'Post for first tenant')

      MultiClient::Client.current_id = @second_tenant
      @post_for_second_tenant = Post.create!(title: 'Post for second tenant')

      MultiClient::Client.current_id = @first_tenant
      expect(Post.all).to eq([@post_for_first_tenant])
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
