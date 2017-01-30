require 'rails_helper'

RSpec.describe "ChatRooms", type: :request do
  describe "GET /chat_rooms" do
    it "works!" do
      get chat_rooms_path
      expect(response).to have_http_status(200)
    end
  end
  describe "GET /chat_rooms/1" do
    it "works!" do
      chat_room = FactoryGirl.create(:valid_chat_room)
      get chat_room_path(chat_room)
      expect(response).to have_http_status(200)
    end
  end
  describe "GET /chat_rooms/1/edit" do
    it "redirects to login!" do
      chat_room = FactoryGirl.create(:valid_chat_room)
      get edit_chat_room_path(chat_room)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
  describe "PATCH /chat_rooms/1" do
    it "redirects to login!" do
      chat_room = FactoryGirl.create(:valid_chat_room)
      patch chat_room_path(chat_room), params: {chat_room: chat_room.attributes}
      expect(response).to redirect_to(new_user_session_path)
    end
  end
  describe "GET /chat_rooms/new" do
    it "redirects to login" do
      get new_chat_room_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
  context "logged user" do
    describe "GET /chat_rooms/new" do
      it "redirects to root" do
        user = FactoryGirl.create(:user)
        sign_in(user)
        get new_chat_room_path
        expect(response).to redirect_to(root_path)
      end
    end
    describe "POST /chat_rooms/" do
      it "redirects to root" do
        user = FactoryGirl.create(:user)
        sign_in(user)
        post chat_rooms_path, params: {chat_room: attributes_for(:valid_chat_room)}
        expect(response).to redirect_to(root_path)
      end
    end
  end
  context "logged author" do
    describe "GET /chat_rooms/new" do
      it "renders to new" do
        user = FactoryGirl.create(:author_user)
        sign_in(user)
        get chat_rooms_path
        expect(response).to have_http_status(200)
      end
    end
    describe "POST /chat_rooms/" do
      it "redirects to show" do
        user = FactoryGirl.create(:author_user)
        sign_in(user)
        post chat_rooms_path, params: {chat_room: attributes_for(:valid_chat_room)}
        expect(response).to redirect_to(assigns(:chat_room))
        follow_redirect!
        expect(response).to render_template(:show)
      end
    end
    describe "GET /chat_rooms/1/edit" do
      it "works!" do
        user = FactoryGirl.create(:author_user)
        sign_in(user)
        chat_room = FactoryGirl.create(:valid_chat_room, user: user)
        get edit_chat_room_path(chat_room)
        expect(response).to have_http_status(200)
      end
      it "redirect to root if not author!" do
        user = FactoryGirl.create(:author_user)
        user1 = FactoryGirl.create(:author_user)
        sign_in(user)
        chat_room = FactoryGirl.create(:valid_chat_room, user: user1)
        get edit_chat_room_path(chat_room)
        expect(response).to redirect_to(root_path)
      end
    end
    describe "PATCH /chat_rooms/1" do
      it "redirects to show!" do
        user = FactoryGirl.create(:author_user)
        sign_in(user)
        chat_room = FactoryGirl.create(:valid_chat_room, user: user)
        patch chat_room_path(chat_room), params: {chat_room: chat_room.attributes}
        expect(response).to redirect_to(assigns(:chat_room))
        follow_redirect!
        expect(response).to render_template(:show)
      end
      it "redirect to root if not author!" do
        user = FactoryGirl.create(:author_user)
        user1 = FactoryGirl.create(:author_user)
        sign_in(user)
        chat_room = FactoryGirl.create(:valid_chat_room, user: user1)
        patch chat_room_path(chat_room), params: {chat_room: chat_room.attributes}
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
