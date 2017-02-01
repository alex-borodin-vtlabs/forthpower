require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "works!" do
      get users_path
      expect(response).to have_http_status(200)
    end
    it "should render js" do
      get users_path, xhr: true
      expect(response.content_type).to eq(Mime[:js])
      expect(response).to have_http_status(200)
    end
  end
  describe "GET /users/1" do
    it "works!" do
      user = FactoryGirl.create(:user)
      get user_path(user)
      expect(response).to have_http_status(200)
    end
  end
  describe "GET /users/1/edit" do
    it "redirects to login" do
      user = FactoryGirl.create(:user)
      get edit_user_path(user)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
  context "logged user" do
    describe "GET /users/1/edit" do
      it "redirects to root" do
        user = FactoryGirl.create(:user)
        editor = FactoryGirl.create(:moderator_user)
        sign_in(editor)
        get edit_user_path(user)
        expect(response).to redirect_to(root_path)
      end
      it "edits himself" do
        user = FactoryGirl.create(:user)
        sign_in(user)
        get edit_user_path(user)
        expect(response).to have_http_status(200)
      end
    end
    describe "PATCH /users/1" do
      it "redirects to root" do
        user = FactoryGirl.create(:user)
        editor = FactoryGirl.create(:moderator_user)
        sign_in(editor)
        patch user_path(user), params: {user: {bio: user.bio}}
        expect(response).to redirect_to(root_path)
      end
      it "edits himself" do
        user = FactoryGirl.create(:user, bio: "azazazaza")
        sign_in(user)
        patch user_path(user),params: {user: {bio: user.bio}}
        expect(response).to have_http_status(200)
      end

      it "not edits role" do
        user = FactoryGirl.create(:moderator_user)
        sign_in(user)
        patch user_path(user),params: {user: {role: 3}}
        expect(response).to redirect_to(root_path)
      end
    end
  end
  context "logged admin" do
    describe "GET /chat_rooms/new" do
      it "redirects to root" do
        user = FactoryGirl.create(:user)
        admin = FactoryGirl.create(:admin_user)
        sign_in(admin)
        get edit_user_path(user)
        expect(response).to have_http_status(200)
      end
    end
    describe "PATCH /users/1" do
      it "redirects to root" do
        user = FactoryGirl.create(:user)
        admin = FactoryGirl.create(:admin_user)
        sign_in(admin)
        patch user_path(user), params: {user: {bio: user.bio}}
        expect(response).to have_http_status(200)
      end
    end
    it "edits role" do
      user = FactoryGirl.create(:admin_user)
      sign_in(user)
      patch user_path(user),params: {user: {role: 3}}
      expect(response).to have_http_status(200)
    end
  end
end
