Template.viewer.onRendered ->
  Session.set('editing', false)

  json = JSON.parse @data.data
  dTree.init json,
    target: '#graph'
    debug: false
    width: $('#graph').width()
    height: $(window).height() * 0.80
    margin:
      top: 0
      right: 0
      bottom: 0
      left: 0
    nodeWidth: 100
    styles:
      node: 'node',
      linage: 'linage',
      marriage: 'marriage',
      text: 'nodeText'

Template.fullscreenViewer.onRendered ->
  json = JSON.parse @data.data
  dTree.init json,
    target: '#fullscreen-graph'
    debug: false
    height: window.outerHeight,
    width: window.innerWidth,
    margin:
      top: 0
      right: 0
      bottom: 0
      left: 0
    nodeWidth: 100
    styles:
      node: 'node',
      linage: 'linage',
      marriage: 'marriage',
      text: 'nodeText'

Template.viewer.helpers
  compiledDescription: ->
    return marked(@description)

  hlStyle: ->
    return hljs.highlight('css', @stylesheet).value

  hlData: ->
    return hljs.highlight('json', @data).value

  editKey: ->
    if @writekey?
      return @writekey
    else
      return Router.current().params.key

Template.viewer.events
  'click #shareButton': ->
    $('#sharemodal').modal('show')
