require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    @tenant = FactoryGirl.create(:tenant)
    assign(:posts, [
      Post.create!(
        :tenant => @tenant,
        :title => "Title",
        :body => "MyText"
      ),
      Post.create!(
        :tenant => @tenant,
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
