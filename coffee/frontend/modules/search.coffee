class Search
  [searchMode, direction, lastSearch, nodes] = [null, null, null, null]
  HIGHLIGHT_CLASS      = '__vrome_search_highlight'
  HIGHLIGHT_CURRENT_ID = '__vrome_search_highlight_current'

  @backward: => @start -1
  desc @backward, 'Start backward search (with selected text)'

  @start: (offset=1) ->
    [searchMode, direction] = [true, offset]

    CmdBox.set
      title: (if direction > 0 then 'Forward search: ?' else 'Backward search: /'),
      pressUp: handleInput, content: getSelected() || lastSearch || ''
  desc @start, 'Start forward search (with selected text)'

  @stop: =>
    return unless searchMode
    searchMode = false
    CmdBox.remove()
    @removeHighlights()

  @removeHighlights: ->
    $('body').unhighlight(className: HIGHLIGHT_CLASS)

  handleInput = (e) =>
    return unless searchMode
    KeyEvent.stopPropagation e
    key = getKey e
    @removeHighlights() unless key is 'Enter' or isControlKey(key)
    lastSearch = CmdBox.get().content
    find lastSearch

  find = (keyword) =>
    $('body').highlight(keyword, className: HIGHLIGHT_CLASS)
    nodes = $(".#{HIGHLIGHT_CLASS}").filter (i, e) -> isElementVisible($(e), true)
    @next(0)

  @prev: => @next -1
  desc @prev, 'Search prev'

  @next: (step=1) ->
    return unless searchMode
    return if nodes.length is 0

    offset = direction * step * times()

    currentNode = nodes.filter("##{HIGHLIGHT_CURRENT_ID}").removeAttr('id')
    currentIndex = Math.max 0, nodes.index(currentNode)
    gotoIndex = rabs(currentIndex + offset, nodes.length)
    $(nodes[gotoIndex]).attr('id', HIGHLIGHT_CURRENT_ID).get(0)?.scrollIntoViewIfNeeded()
  desc @next, 'Search next'

  @openCurrentNewTab: => @openCurrent(true)
  desc @openCurrentNewTab, 'Open selected element in a new tab'

  @openCurrent: (newTab) ->
    return unless searchMode
    clickElement $("##{HIGHLIGHT_CURRENT_ID}"), {ctrl: newTab}
    @stop()
  desc @openCurrent, 'Open selected element in current tab'

  @onAcceptKeyPressed: =>
    return unless searchMode
    if CmdBox.isActive()
      InsertMode.blurFocus()
    else
      @openCurrent(false)

root = exports ? window
root.Search = Search
