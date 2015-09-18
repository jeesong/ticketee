# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# only runs when the page is fully loaded
$(-> 
  $('a#add_another_file').click(->
    url = "/files/new?number=" + $('#files input').length
    $.get(url,
      (data)->
        $('#files').append(data)
    )
  )
)