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
      page.find('a[data-vote="like"]').click
      expect(page).to have_content '1'
      expect(page).to have_css('.votes-container[data-voted="like"]')
      page.find('a[data-vote="bad"]').click
      expect(page).to have_content '0'
      expect(page).to have_css(".votes-container[data-voted='none']")
      page.find('a[data-vote="bad"]').click
      expect(page).to have_content '-1'
      expect(page).to have_css(".votes-container[data-voted='bad']")
      page.find('a[data-vote="bad"]').click
      expect(page).to have_content '0'
      expect(page).to have_css(".votes-container[data-voted='none']")
  end
end
