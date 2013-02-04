money = (amt) ->
  if amt < 1000
    "$#{ Math.round(amt) }"
  else
    "$#{ Math.round(amt/1000) }k"

update = (range) ->
  $('.slider')
    .find('.ui-slider-handle .marker')
      .each ->
        $(this).text(money range.shift())

transition = (text) ->
  if $('.after').length > 0
    return $('.after').html(text)

  $('#contact form')
    .slideUp ->
      $('.after').slideDown()
    .parent()
    .append $('<div>', class: 'after')
      .html(text)

$ ->
  init_values = [5000, 20000]

  $('.slider')
    .slider
      range: true
      min: 500
      max: 50000
      step: 100
      values: init_values
      slide: (e, ui) -> update(ui.values)
    .find('.ui-slider-handle')
      .append($('<div>', class: 'marker'))
      # Prevent browser link outline
      .focus HTMLElement::blur

  update init_values

  $('#contact form')
    .submit (e) ->
      e.preventDefault()
      # Gather information
      submission = _.extend
        budget: $('.slider').slider('values')
      , _.object _.map ['name', 'company', 'email', 'project'], (field) ->
        [field, $("[name=#{ field }]").val()]

      transition "Sending..."

      $.post('/contact', submission)
        .done ->
          transition "Thanks! We'll be in touch with you soon."
        .fail ->
          transition "An error has occured. We've been notified, but feel free to email <a href='mailto:admin@323productions.com'>admin@323productions.com</a> to let us know."
