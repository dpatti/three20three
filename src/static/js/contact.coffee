money = (amt) ->
  if amt <= 1000
    "$#{ Math.round(amt) }"
  else
    "$#{ Math.round(amt/1000) }k"

update = (range) ->
  $('.slider')
    .find('.ui-slider-handle .marker')
      .each ->
        $(this).text(money range.shift())

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
