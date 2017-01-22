//= require application

describe("messages", function() {

  beforeEach(function(){
      $("<div id=\"messages\" data-chat-room-id=\"123\"><div class=\"card\"></div><form id=\"new_message\"><textarea id=\"message_body\">123</textarea></form></div>").appendTo('body');
      $(document).trigger('turbolinks:load');
  });

  afterEach(function(){
      $('#messages').remove();
  });

  it ("should render new message", function() {
    App.global_chat.received({message: "<div class=\"card\"></div>"});
    expect($(".card").length).toEqual(2);
  });
  it ("should have right identifier", function() {
    expect(App.global_chat.identifier).toEqual("{\"channel\":\"ChatRoomsChannel\",\"chat_room_id\":123}");
  });

  it ("should have send_message", function() {
    expect(typeof App.global_chat.send_message).toBe('function');

  });

  it ("should send message", function() {
    spyOn(App.global_chat, 'send_message');
    $('#new_message').submit();

    expect(App.global_chat.send_message).toHaveBeenCalled()
  });
});

describe("votes", function() {

  beforeEach(function(){
      $("<div class=\"votes-container\" data-chat-room-id=\"123\"><a href=\"#\">Like</a></div><div class=\"votes-container\" data-chat-room-id=\"321\"><a href=\"#\">Like</a></div>").appendTo('body');
      $(document).trigger('turbolinks:load');
  });

  afterEach(function(){
      $('.votes-container').remove();
  });

  it ("should render vote", function() {
    App.votes[123].received({vote: "vote"});
    expect($(".votes-container[data-chat-room-id=\"123\"]").text()).toEqual("vote");
  });

  it ("should have right identifier", function() {
    expect(App.votes[123].identifier).toEqual("{\"channel\":\"VotesChannel\",\"chat_room_id\":123}");
  });

  it ("should have send_message", function() {
    expect(typeof App.votes[123].send_message).toBe('function');

  });

  it ("should send message", function() {
    spyOn(App.votes[123], 'send_message');
    $('.votes-container').find('a').first().trigger('click');

    expect(App.votes[123].send_message).toHaveBeenCalled()
  });
});
describe("rooms", function() {

  beforeEach(function(){
      $("<div id=\"chat-rooms\"><div class=\"card\"></div></div>").appendTo('body');
      $(document).trigger('turbolinks:load');
  });

  afterEach(function(){
      $('#chat-rooms').remove();
  });

  it ("should render new chat room", function() {
    App.index_room.received({chat_room: "<div class=\"card\"></div>"});
    expect($(".card").length).toEqual(2);
  });

  it ("should have right identifier", function() {
    expect(App.index_room.identifier).toEqual("{\"channel\":\"ChatRoomsIndexChannel\"}");
  });
});
