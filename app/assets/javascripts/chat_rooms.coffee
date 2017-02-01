# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery(document).on 'turbolinks:load', ->
  $('#post').froalaEditor
    heightMin: 300
    theme: 'gray'
    imageUploadURL: '/attachments.json',
    imageUploadMethod: 'POST',
    imageUploadParams: {'authenticity_token': $( 'meta[name="csrf-token"]' ).attr( 'content' )}

  infinite = $('.infinite')
  yeld_container = $('.yeld-container')
  if infinite.length > 0
    preloader=$("<div class=\"preloader text-xs-center\"><i class=\"fa fa-spinner fa-pulse fa-3x fa-fw\"></i></div>")
    yeld_container.append preloader
    yeld_container.on 'scroll', ->
      if !App.ajax_begin and ($(this).height() - $(this).scrollTop() < 100) and ($('.preloader').length > 0)
        preloader.fadeIn()
        App.ajax_begin = true
        $.ajax
          url: infinite.data 'url' + ".js"
          type: 'GET'
          processData: false,
          contentType: false,
          dataType: 'script'
          data: "padding=#{$('.infinite-block').length}"
          error: (data, textStatus, jqXHR) ->
            console.log textStatus
          success: (data, textStatus, jqXHR) ->
            preloader.fadeOut()
            App.ajax_begin = false
