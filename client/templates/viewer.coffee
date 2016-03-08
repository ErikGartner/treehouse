handlebarsRenderer = (name, extra, textClass) ->
  context = {name: name, extra: extra, textClass: textClass}
  renderFunction = SpacebarsCompiler.compile @data.textTemplate
  view = new Blaze.View eval(renderFunction)
  html = Blaze.toHTMLWithData view, context

  clean = sanitizeHtml html
  html = '<p align="center" class="' + textClass + '">' + clean + '</p>'
  return html

dTreeOptions =
  target: '#graph'
  debug: false
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

Template.viewer.onRendered ->
  json = JSON.parse @data.data
  dTreeOptions.width = $('#graph').width()
  dTreeOptions.height = $(window).height() * 0.80
  if @data.textTemplate? and @data.textTemplate != ''
    dTreeOptions.callbacks = {textRenderer: _.bind(handlebarsRenderer, @)}

  dTree.init json, dTreeOptions

Template.fullscreenViewer.onRendered ->
  json = JSON.parse @data.data
  dTreeOptions.width = window.innerWidth
  dTreeOptions.height = window.outerHeight
  dTreeOptions.target = '#fullscreen-graph'
  if @data.textTemplate? and @data.textTemplate != ''
    dTreeOptions.callbacks = {textRenderer: _.bind(handlebarsRenderer, @)}

  dTree.init json, dTreeOptions

Template.viewer.helpers
  compiledDescription: ->
    return marked(@description)

  hlStyle: ->
    return hljs.highlight('css', @stylesheet).value

  hlTemplate: ->
    return hljs.highlight('html', @textTemplate).value

  hlData: ->
    return hljs.highlight('json', @data).value

  editKey: ->
    if @writekey?
      return @writekey
    else
      return Router.current().params.key

Template.viewer.events
  'click #shareButton': (event) ->
    $('#sharemodal').modal('show')
