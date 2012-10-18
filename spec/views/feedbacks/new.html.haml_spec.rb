require 'spec_helper'

describe "feedbacks/new" do
  before(:each) do
    assign(:feedback, stub_model(Feedback,
      :title => "MyString",
      :body => "MyString",
      :user => nil
    ).as_new_record)
  end

  it "renders new feedback form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => feedbacks_path, :method => "post" do
      assert_select "input#feedback_title", :name => "feedback[title]"
      assert_select "input#feedback_body", :name => "feedback[body]"
      assert_select "input#feedback_user", :name => "feedback[user]"
    end
  end
end
