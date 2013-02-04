class Navigator
  @PAGES: ['work', 'about', 'services', 'contact']

  constructor: ->
    @pages = []

    # Check current location
    current = document.location.pathname
    @show current

    # Watch for history on pop
    if history.pushState
      history.replaceState page: current, "", current
      $(window).bind 'popstate', (e) =>
        page = history.state?.page
        @show(page) if page?

  to: (page) ->
    @show page

    # Alter history
    if history.pushState
      history.pushState {page}, "", page

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
    unless /^http/.test(href)
      $(this).click (e) =>
        # Let middle clicks open
        return unless e.which == 1
        e.preventDefault()
        navigator.to(href)
