class Tile
  WIDTH_BOUNDS: [900, 1290]

  constructor: (@name, @tiles, cfg) ->
    for key, value of cfg
      @[key] = value

    @tile =
      $("<div>")
        .addClass('tile')
        .append($("<img>", src: "static/images/tiles/#{ @image }.png")
          .addClass('standard'))
        .append($("<img>", src: "static/images/tiles/#{ @image }-rollover.jpg")
          .addClass('rollover'))
        .hover ->
          # Fade to rollover
          $(@).find('.rollover').animate(opacity: 1, 100)
        , ->
          # Fade back
          $(@).find('.rollover').animate(opacity: 0, 100)

  position: (scale) ->
    return @cache if @cache

    if @anchor?.to
      anchor = @tiles[@anchor.to]
      { left, top } = anchor.position(scale)
      if /right/.test @anchor.point
        left += (anchor.size.width + @spacing) * scale
      if /bottom/.test @anchor.point
        top += (anchor.size.height + @spacing) * scale
    else
      # Anchored to page
      left = 0
      top = 0
    
    @cache = { left, top }

  render: (scale=1) ->
    delete @cache
    $("#tiles").append(@tile.css(
      _.extend @position(scale),
        width: scale * @size.width
        height: scale * @size.height
    ))

$(->
  tiles = {}
  for name, cfg of work.tiles
    # Create tile
    tiles[name] = new Tile name, tiles, _.extend(cfg, spacing: work.spacing)

  render_tiles = _.debounce ->
    width = Tile::WIDTH_BOUNDS.concat($(window).width()).sort((a,b) -> a-b)[1]
    for name, tile of tiles
      tile.render(width / Tile::WIDTH_BOUNDS[1])
  , 250

  render_tiles()

  $(window).resize(render_tiles)
)
