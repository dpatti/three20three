class Tile
  constructor: (@name, @tiles, cfg) ->
    for key, value of cfg
      @[key] = value

  position: ->
    if @anchor?.to
      anchor = @tiles[@anchor.to]
      { left, top } = anchor.position()
      if /right/.test @anchor.point
        left += anchor.size.width + @spacing
      if /bottom/.test @anchor.point
        top += anchor.size.height + @spacing
    else
      # Anchored to page
      left = 0
      top = 0
    
    { left, top }

  render: ->
    $("#tiles").append(@tile.css(@position()))

$(->
  tiles = {}
  for name, cfg of work.tiles
    # Create tile
    tiles[name] = new Tile name, tiles, _.extend(cfg,
      spacing: work.spacing
      tile: $("<div>")
        .addClass('tile')
        .append $("<img>")
            .attr('src', "static/images/tiles/#{ cfg.image }.png")
        .append $("<img>")
            .attr('src', "")
            # .hover ->
            #   # Fade to rollover
            # , ->
            #   # Fade back
    )

  render_tiles = ->
    for name, tile of tiles
      tile.render()

  # render_tiles()
)
