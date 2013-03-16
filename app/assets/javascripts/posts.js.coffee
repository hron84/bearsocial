jQuery ->

  $('.post').each (i, post) ->
    if($(post).hasClass('starred'))
      $(post).find('.star').hide()
    else
      $(post).find('.unstar').hide()

  $(document).on 'click', '.star, .unstar', (e) ->
    link = $(this)
    star = link.find('i')
    star = $(star)

    $.ajax
      type: 'PUT'
      url: $(this).attr('href')
      dataType: 'json'
      error: (jqXHR, status, error) ->
        $.facebox(jqXHR.responseText)
      success: (data, textStatus, jqXHR) ->
        # If it is a 'star' button, transform it to 'unstar'
        link.hide()
        if link.hasClass('star')
          link.parent().parent().find('.unstar').show()
        else
          link.parent().parent().find('.star').show()

    e.preventDefault()

  $(document).on 'keyup', '.post-form textarea', (e) ->
    bodysize = this.value.length;
    console.log bodysize
    $('.counter span').text(bodysize)
    if bodysize > 1000
      $('.counter span').addClass('label-important')
      $('.actions input[type="submit"]').attr('disabled', 'disabled')
    else
      $('.counter span').removeClass('label-important')
      $('.actions input[type="submit"]').removeAttr('disabled')

  $('.add-post, .reply, .in-reply-to').on 'click', (e) ->
    $.facebox
      ajax: $(this).attr('href')
      e.preventDefault()

  $(document).on 'click', '.cancel', (e) ->
    $(document).trigger('close.facebox')
    e.preventDefault()

