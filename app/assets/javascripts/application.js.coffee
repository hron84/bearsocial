#  This is a manifest file that'll be compiled into application.js, which will include all the files
#  listed below.
# 
#  Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
#  or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
# 
#  It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
#  the compiled file.
# 
#  WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
#  GO AFTER THE REQUIRES BELOW.
#
# = require console
# = require jquery
# = require jquery_ujs
# = require twitter/bootstrap
# = require_tree .

jQuery ->

  # Wrapper to use Twitter bootstrap's modal() instead of facebox
  # because that not displays well on mobile browsers
  window.globalModal = (title, message, buttons = true) ->

    widget = $('#modalHelper')

    if(title == null)
      widget.find('.modal-header').hide()
      widget.find('.modal-title').html('')
    else
      widget.find('.modal-header').show()
      widget.find('.modal-title').html(title)

    if buttons
      widget.find('.modal-footer').show()
    else
      widget.find('.modal-footer').hide()

    widget.find('.modal-body p').html(message)
    widget.modal()

  window.remoteModal = (title, url, buttons = false) ->
    widget = $('#modalHelper')
    console.log('remoteModal: setting title')

    if(title == null)
      widget.find('.modal-header').hide()
    else
      widget.find('.modal-header').show()
      widget.find('.modal-title').html(title)

    if buttons
      widget.find('.modal-footer').show()
    else
      widget.find('.modal-footer').hide()

    console.log('remoteModal: Requesting ' + url)
    widget.find('.modal-body p').load url, (responseText, textStatus, jqXHR) ->
      widget.modal()


  $(document).on 'click', '.follow, .unfollow', (e) ->
    link = $(this)

    $.ajax
      type: 'PUT'
      dataType: 'json'
      url: link.attr('href')
      error: (jqXHR, status, error) ->
        console.error(['followClick', status, error, jqXHR.responseText])
        globalModal("An error occurred", jqXHR.responseText)
      success: (data, textStatus, jqXHR) ->
        link.hide()

        if link.hasClass('follow')
          link.parent().parent().find('.unfollow').show()
        else
          link.parent().parent().find('.follow').show()

    e.preventDefault()

  $(document).on 'click', '.befriend, .unfriend', (e) ->
    link = $(this)

    $.ajax
      type: 'PUT'
      dataType: 'json'
      url: link.attr('href')
      error: (jqXHR, status, error) ->
        console.error(['friendClick', status, error, jqXHR.responseText])
        globalModal("An error occurred", jqXHR.responseText)
      success: (data, textStatus, jqXHR) ->
        link.hide()

        if link.hasClass('befriend')
          link.parent().parent().find('.unfriend').show()
        else
          link.parent().parent().find('.befriend').show()

    # We do not reload the page to provide a possibility to user to cancel its decision

    e.preventDefault()

    e.stopPropagation() # It is needed to prevent :confirm handler to do terrible things with the user

  $(document).on 'click', '.profile-link', (e) ->
#    $.facebox
#      ajax: $(this).attr('href')
    remoteModal(null, $(this).attr('href'), true)

    e.preventDefault()
