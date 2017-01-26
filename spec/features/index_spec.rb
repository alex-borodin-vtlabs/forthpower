feature "Roles" do
  background do
    user = FactoryGirl.create(:user, email: "luke@skywalker.sw", avatar_url: "vk.com/kek.jpg", password: 'kekkekkek', password_confirmation: 'kekkekkek')
    author = FactoryGirl.create(:author_user, email: "luke1@skywalker.sw", avatar_url: "vk.com/kek.jpg", password: 'kekkekkek', password_confirmation: 'kekkekkek')
    moderator = FactoryGirl.create(:moderator_user, email: "luke2@skywalker.sw", avatar_url: "vk.com/kek.jpg", password: 'kekkekkek', password_confirmation: 'kekkekkek')
    admin = FactoryGirl.create(:admin_user, email: "luke3@skywalker.sw", avatar_url: "vk.com/kek.jpg", password: 'kekkekkek', password_confirmation: 'kekkekkek')
  end

  scenario "Signing in with correct credentials" do
    visit '/'
    within("#new_user") do
      fill_in 'Email', with: 'luke@skywalker.sw'
      fill_in 'Password', with: 'kekkekkek'
    end
    click_button 'Log in'
    expect(page).to have_content 'luke'
  end

  scenario "Signing in with author" do
    visit '/'
    within("#new_user") do
      fill_in 'Email', with: 'luke1@skywalker.sw'
      fill_in 'Password', with: 'kekkekkek'
    end
    click_button 'Log in'
    expect(page).to have_content 'New article'
  end

  given(:other_user) { FactoryGirl.build(:user, email: 'other@example.com', password: 'rous', password_confirmation: 'rous') }

  scenario "Signing in as another user" do
    visit '/'
    within("#new_user") do
      fill_in 'Email', with: other_user.email
      fill_in 'Password', with: other_user.password
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password'
  end
end
feature "Main Page" do
  background do
    user = FactoryGirl.create(:user, email: "luke@skywalker.sw", avatar_url: "vk.com/kek.jpg", password: 'kekkekkek', password_confirmation: 'kekkekkek')
    visit '/'
    within("#new_user") do
      fill_in 'Email', with: 'luke@skywalker.sw'
      fill_in 'Password', with: 'kekkekkek'
    end
    click_button 'Log in'
  end
  scenario "Log out" do
    page.find('a[href="/users/sign_out"]').click
    expect(page).to have_content 'Log in'
  end
end

feature "Articles" do
  background do
    @chat_room1 = FactoryGirl.create(:valid_chat_room)
    @chat_room2 = FactoryGirl.create(:valid_chat_room)
    user = FactoryGirl.create(:user, email: "luke@skywalker.sw", password: 'kekkekkek', password_confirmation: 'kekkekkek')
    visit '/'
    within("#new_user") do
      fill_in 'Email', with: 'luke@skywalker.sw'
      fill_in 'Password', with: 'kekkekkek'
    end
    click_button 'Log in'
  end
  scenario "Must be 2 chat rooms" do
    within("#chat-rooms") do
      expect(page).to have_content @chat_room1.title
      expect(page).to have_content @chat_room2.title
      expect(page).to have_content @chat_room1.post
      expect(page).to have_content @chat_room2.post
    end
  end
  scenario "Like", :js => true do
    within(".votes-container[data-chat-room-id=\"#{@chat_room2.id}\"]") do
      page.find('a[data-vote="like"]').click
      expect(page).to have_content '1'
    end
    within(".votes-container[data-chat-room-id=\"#{@chat_room1.id}\"]") do
      expect(page).to have_content '0'
    end
  end
end
