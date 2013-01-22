class Tile
  constructor: (@name, @tiles, cfg) ->
    for key, value of cfg
      @[key] = value

    @tile =
      $("<div>")
        .addClass('tile')
        .append($("<img>", src: "/static/images/tiles/#{ @image }.jpg")
          .addClass('standard'))
        .append($("<img>", src: "/static/images/tiles/#{ @image }-rollover.jpg")
          .addClass('rollover'))
        .hover ->
          # Fade to rollover
          $(@).find('.rollover').animate(opacity: 1, 100)
        , ->
          # Fade back
          $(@).find('.rollover').animate(opacity: 0, 100)
        .click @click

  position: ->
    return @cache if @cache

    if @anchor?.to
      { left, top, right, bottom } = @tiles[@anchor.to].position()
      if /right/.test @anchor.point
        left = right + @spacing
      if /bottom/.test @anchor.point
        top = bottom + @spacing
    else
      # Anchored to page
      left = 0
      top = 0
    
    @cache = {
      left
      top
      right: left + @size.width
      bottom: top + @size.height
    }

  render: ->
    delete @cache
    { left, top, right } = @position()
    $("#tiles").append(@tile.css {
      left
      top
      width: right - left
    })

  click: (e) =>
    return unless @popout
    e.stopPropagation()

    Popout.get().show _.defaults @popout, { @image }

class Popout
  @get: ->
    @instance ?= new Popout()

  constructor: ->
    @el = $('#popout')
    @background = $('#blackout')
    $('body,html').bind 'DOMMouseScroll mousewheel', (e) =>
     if @locked and (e.which > 0 or e.type == "mousedown" or e.type == "mousewheel")
       e.preventDefault()

  show: (cfg) ->
    return if @locked
    @background.fadeIn()
    @set_image(cfg.image, cfg.offset)
    @scroll_content =>
      # Don't fade in if we already triggered a hide
      if @locked
        @el.fadeIn =>
          # Delay setting flash video so we don't get some weird
          # partial-transparency display bug
          @set_content(cfg.content)
    @locked = true

  set_image: (image, offset) ->
    @el.find('img.header')
      .attr(src: "/static/images/popouts/#{ image }.png")
      .css(top: -offset)

  set_content: (content) ->
    @el.find('iframe.content')
      # Transparent wmode parameter so that we can z-index over the video
      .attr(src: "#{ content }?wmode=transparent")

  scroll_content: (next) ->
    # Anchor based on the bottom image's distance from the bottom of the window
    $('html,body').animate
      scrollTop: 1120 - $(window).height()
    , 400, next

  hide: ->
    @locked = false
    @background
      .add(@el)
      .stop(true)
      .fadeOut =>
        # Clear the video and image to stop background music and prevent flash
        # of content when the next popup is triggered
        @set_image('', 0)
        @set_content('about:blank')

$ ->
  if $('#tiles').length
    tiles = {}
    for name, cfg of work.tiles
      # Create tile
      tiles[name] = new Tile name, tiles, _.extend(cfg, spacing: work.spacing)
      tiles[name].render()

    $(document).click ->
      Popout.get().hide()
