require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  before(:each) do
    @client = FactoryGirl.create(:multi_client_client)
    @post = assign(:post, Post.create!(
      :client => @client,
      :title => "Title",
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
