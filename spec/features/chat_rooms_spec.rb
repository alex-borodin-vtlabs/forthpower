feature "Chat Room" do
  background do
    user = FactoryGirl.create(:user, email: "luke@skywalker.sw", password: 'kekkekkek', password_confirmation: 'kekkekkek')
    visit '/'
    within("#new_user") do
      fill_in 'Email', with: 'luke@skywalker.sw'
      fill_in 'Password', with: 'kekkekkek'
    end
    click_button 'Log in'
    chat_room = FactoryGirl.create(:valid_chat_room)
    visit chat_room_path(chat_room)
  end
  scenario "Add Message", :js => true do
    within("#new_message") do
      fill_in 'Comment', with: 'azazazaza'
      click_button 'Post'
    end
    within("#messages") do
      expect(page).to have_content 'azazazaza'
    end
  end
  scenario "Like", :js => true do
    within(".votes-container") do
      page.find('a[data-vote="like"]').click
      expect(page).to have_content '1'
    end
  end
end
