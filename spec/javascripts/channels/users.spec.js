//= require application

describe("online avatars", function() {

  beforeEach(function(){
      $('<span class="user-avatar" data-user="123"></span><span class="user-avatar" data-user="1223"></span>').appendTo('body');
  });

  afterEach(function(){
      $('.user-avatar').remove();
  });

  it ("should render avatar", function() {
    $(document).trigger('turbolinks:load');
    App.avatars[123].received({user: "avatar  image"});
    expect($(".user-avatar[data-user=\"123\"]").text()).toEqual("avatar  image");
  });

  it ("should have right identifier", function() {
    expect(App.avatars[123].identifier).toEqual("{\"channel\":\"UsersOnlineChannel\",\"user_id\":123}");
  });

});
