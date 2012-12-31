class Tile
  constructor: (@name, @tiles, cfg) ->
    for key, value of cfg
      @[key] = value

    @tile =
      $("<div>")
        .addClass('tile')
        .append($("<img>", src: "static/images/tiles/#{ @image }.jpg")
          .addClass('standard'))
        .append($("<img>", src: "static/images/tiles/#{ @image }-rollover.jpg")
          .addClass('rollover'))
        .hover ->
          # Fade to rollover
          $(@).find('.rollover').animate(opacity: 1, 100)
        , ->
          # Fade back
          $(@).find('.rollover').animate(opacity: 0, 100)
        .click @popout

  position: () ->
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

  render: () ->
    delete @cache
    { left, top, right } = @position()
    $("#tiles").append(@tile.css {
      left
      top
      width: right - left
    })

  popout: (e) =>
    return unless @expand

    e.stopPropagation()

    @pop_el ?=
      $("<div>")
        .addClass('popout')
        .append($("<img>", src: "static/images/tiles/#{ @image }-popup.png"))

    # Setup popup corner and dims
    dims = { }
    corners = _.map(_.first(_.keys(@expand), 2),
      (desc) -> desc.split(/(?=left|right)/))
    tiles = _.map(_.first(_.values(@expand), 2),
      (tile) => @tiles[tile].position())

    # First key is our anchor point
    for prop  in _.first(corners)
      dims[prop] = _.first(tiles)[prop]

    # Second key is our sizing
    alignment = _.intersection(_.first(corners), _.last(corners))
    get_sizing = (min, max) ->
      _.max(_.pluck(tiles, max)) - _.min(_.pluck(tiles, min))

    if "left" in alignment or "right" in alignment
      dims.height = get_sizing 'top', 'bottom'
    else
      dims.width = get_sizing 'left', 'right'

    @pop_el.css(dims)
    @pop_el.show().animate(opacity: 1, 300)
    $("#dim").fadeIn()

  popin: =>
    @pop_el?.animate(opacity: 0, -> $(@).hide())
    $("#dim").fadeOut()

$(->
  tiles = {}
  for name, cfg of work.tiles
    # Create tile
    tiles[name] = new Tile name, tiles, _.extend(cfg, spacing: work.spacing)

  render_tiles = _.debounce ->
    for name, tile of tiles
      tile.render()
  , 250

  render_tiles()

  $(document).click ->
    for name, tile of tiles
      tile.popin()


  $("#content").append($("<div>", id: "dim").hide())
)
