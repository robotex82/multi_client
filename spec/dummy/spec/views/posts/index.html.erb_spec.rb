require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    @client = FactoryGirl.create(:multi_client_client)
    assign(:posts, [
      Post.create!(
        :client => @client,
        :title => "Title",
        :body => "MyText"
      ),
      Post.create!(
        :client => @client,
        :title => "Title",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
