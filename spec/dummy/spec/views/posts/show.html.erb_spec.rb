require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  before(:each) do
    @tenant = FactoryGirl.create(:tenant)
    @post = assign(:post, Post.create!(
      :tenant => @tenant,
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
