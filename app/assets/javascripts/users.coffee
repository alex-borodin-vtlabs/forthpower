# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery(document).on 'turbolinks:load', ->
  $('#bio').froalaEditor
    heightMin: 300
    theme: 'gray'
    imageUploadURL: '/attachments.json',
    imageUploadMethod: 'POST',
    imageUploadParams: {'authenticity_token': $( 'meta[name="csrf-token"]' ).attr( 'content' )}
