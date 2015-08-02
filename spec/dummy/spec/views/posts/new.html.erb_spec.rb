require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  before(:each) do
    @client = FactoryGirl.create(:multi_client_client)
    assign(:post, Post.new(
      :client => @client,
      :title => "MyString",
      :body => "MyText"
    ))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do

      assert_select "input#post_client_id[name=?]", "post[client_id]"

      assert_select "input#post_title[name=?]", "post[title]"

      assert_select "textarea#post_body[name=?]", "post[body]"
    end
  end
end
