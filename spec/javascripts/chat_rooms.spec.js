//= require application

describe("New Chat Room", function() {
  var spyEvent;

  beforeEach(function(){
      $('<textarea id="post"></textarea>').appendTo('body');
  });

  afterEach(function(){
      $('#post').remove();
      $('.fr-box').remove();
  });

  it ("should render editor", function() {
    $(document).trigger('turbolinks:load');

    expect($('.fr-box').length).toEqual(1);
  });
});
