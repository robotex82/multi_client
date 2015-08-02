require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    it "should redirect to the root path" do
      get posts_path
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /posts (with subdomain)" do
    before :each do
      @current_client = FactoryGirl.create(:multi_client_client)
      # MultiClient::Client.current_id = current_client.id
    end

    it "should redirect to the root path" do
      get posts_url(subdomain: @current_client.subdomain)
      expect(response).to have_http_status(200)
    end
  end
end
