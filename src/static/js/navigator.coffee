class Navigator
  @PAGES: ['work', 'about', 'services', 'contact']

  constructor: ->
    @pages = []

    # Check current location
    @show document.location.pathname

  to: (page) ->
    @show page

  parse: (href) -> href.replace(/\W+/g, '').toLowerCase()

  show: (href) ->
    page = @parse(href)
    index = Math.max(Navigator.PAGES.indexOf(page), 0)

    if !@current?
      # First show, just display it
      @content(index)
        .show()
    else
      # Current is our index, so we need to transition
      movement = @current-index
      for i in [@current..index]
        pos = (i - @current)
        @content(i)
          .css(position: 'absolute', left: "#{ 100*pos + 50 }%")
          .show()
          .animate(left: "#{ 100*(pos+movement) + 50 }%")

    @current = index

  content: (page) -> $("##{ Navigator.PAGES[page] }")

$ ->
  navigator = new Navigator()
  # Hook links
  $('#header a').each ->
    href = $(this).attr('href')
    unless 'http' in href
      $(this).click (e) =>
        e.preventDefault()
        navigator.to(href)
