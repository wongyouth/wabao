require 'spec_helper'

describe "feedbacks/index" do
  before(:each) do
    assign(:feedbacks, [
      stub_model(Feedback,
        :title => "Title",
        :body => "Body",
        :user => nil
      ),
      stub_model(Feedback,
        :title => "Title",
        :body => "Body",
        :user => nil
      )
    ])
  end

  it "renders a list of feedbacks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Body".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
