require 'rails_helper'

RSpec.describe "attachments/new", type: :view do
  before(:each) do
    assign(:attachment, Attachment.new(
      :picture => "MyString"
    ))
  end

  it "renders new attachment form" do
    render

    assert_select "form[action=?][method=?]", attachments_path, "post" do

      assert_select "input#attachment_picture[name=?]", "attachment[picture]"
    end
  end
end
