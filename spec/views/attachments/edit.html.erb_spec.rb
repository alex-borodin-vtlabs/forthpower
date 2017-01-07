require 'rails_helper'

RSpec.describe "attachments/edit", type: :view do
  before(:each) do
    @attachment = assign(:attachment, Attachment.create!(
      :picture => "MyString"
    ))
  end

  it "renders the edit attachment form" do
    render

    assert_select "form[action=?][method=?]", attachment_path(@attachment), "post" do

      assert_select "input#attachment_picture[name=?]", "attachment[picture]"
    end
  end
end
