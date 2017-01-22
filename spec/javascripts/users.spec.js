//= require application

describe("Edit User", function() {

  beforeEach(function(){
      $('<textarea id="bio"></textarea>').appendTo('body');
  });

  afterEach(function(){
      $('#bio').remove();
      $('.fr-box').remove();
  });

  it ("should render editor", function() {
    $(document).trigger('turbolinks:load');
    expect($('.fr-box').length).toEqual(1);
  });
});
