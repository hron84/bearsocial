jQuery ->

#  $('.post').each (i, post) ->
#    if($(post).hasClass('starred'))
#      $(post).find('.star').hide()
#    else
#      $(post).find('.unstar').hide()

  $(document).on 'click', '.youtube-link', (e) ->
    regex = /https?:\/\/(www\.)?(youtube.com\/watch\?v=|youtu.be\/)([a-zA-Z0-9]+)po/
    link = $(this).attr('href')
    match = regex.exec(link)

    html = '<iframe width="480" height="360" src="http://www.youtube.com/embed/%VIDEO%" frameborder="0" allowfullscreen></iframe>'
            .replace('%VIDEO%', match[3]);

    globalModal("YouTube Video", html)

    e.preventDefault()
    e.stopPropagation()

  $(document).on 'click', '.star, .unstar', (e) ->
    link = $(this)

    $.ajax
      type: 'PUT'
      url: $(this).attr('href')
      dataType: 'json'
      error: (jqXHR, status, error) ->
        globalModal("An error occurred", jqXHR.responseText)
      success: (data, textStatus, jqXHR) ->
        # If it is a 'star' button, transform it to 'unstar'
        link.hide()
        if link.hasClass('star')
          link.parent().parent().find('.unstar').show()
        else
          link.parent().parent().find('.star').show()

    e.preventDefault()

  $(document).on 'keyup', '.post-form textarea, .post-form input.youtube', (e) ->

    bodysize = $('.post-form textarea').val().length;

    if($('.post-form input.youtube').val().length > 0)
      bodysize += 29

    console.log bodysize
    $('.counter span').text(bodysize)
    if bodysize > 1000
      $('.counter span').addClass('label-important')
      $('.actions input[type="submit"]').attr('disabled', 'disabled')
    else
      $('.counter span').removeClass('label-important')
      $('.actions input[type="submit"]').removeAttr('disabled')

  # Facebox pushing up at various links
  $('.add-post, .reply, .edit-post, .show-post, .in-reply-to').on 'click', (e) ->
#    $.facebox
#      ajax: $(this).attr('href')
    remoteModal(null, $(this).attr('href'))

    e.preventDefault()

  $(document).on 'click', '.cancel', (e) ->
    #$(document).trigger('close.facebox')
    e.preventDefault()

