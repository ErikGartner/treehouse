handlebarsRenderer = (name, extra, textClass) ->
  context = {name: name, extra: extra, textClass: textClass}
  renderFunction = SpacebarsCompiler.compile @data.textTemplate
  view = new Blaze.View eval(renderFunction)
  html = Blaze.toHTMLWithData view, context

  clean = sanitizeHtml html, allowedTags: sanitizeHtml.defaults.allowedTags.concat([ 'img' ])
  html = '<p align="center" class="' + textClass + '">' + clean + '</p>'
  return html

dTreeOptions =
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
  @autorun (comp) =>
    data = Template.currentData()
    document.title = "#{data.owner}/#{data.name} - Treehouse"
    json = JSON.parse data.data
    dTreeOptions.width = $('#graph').width()
    dTreeOptions.height = $(window).height() * 0.80
    dTreeOptions.target = '#graph'
    if data.textTemplate? and data.textTemplate != ''
      dTreeOptions.callbacks = {textRenderer: _.bind(handlebarsRenderer, @)}

    dTree.init json, dTreeOptions

Template.fullscreenViewer.onRendered ->
  @autorun (comp) =>
    data = Template.currentData()
    document.title = "#{data.owner}/#{data.name} - Treehouse"
    json = JSON.parse data.data
    dTreeOptions.width = window.innerWidth
    dTreeOptions.height = window.outerHeight
    dTreeOptions.target = '#fullscreen-graph'
    if data.textTemplate? and data.textTemplate != ''
      dTreeOptions.callbacks = {textRenderer: _.bind(handlebarsRenderer, @)}

    dTree.init json, dTreeOptions

Template.gistViewer.onRendered ->
  Session.set 'gistData', undefined
  getGist @data.gist, (err, res) ->
    if err?
      console.log err
      return
    Session.set 'gistData', res

Template.gistFullscreenViewer.onRendered ->
  Session.set 'gistData', undefined
  getGist @data.gist, (err, res) ->
    if err?
      console.log err
      return
    Session.set 'gistData', res

Template.viewer.helpers
  compiledDescription: ->
    return marked @description

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

  readLink: ->
    if @gist?
      return Router.routes['tree.view.gist'].url({gist: @gist.id})
    else
      return Router.routes['tree.view.guest'].url({slug: @slug})

  fullscreenLink: ->
    if @gist?
      return Router.routes['tree.view.fullscreenGist'].url({gist: @gist.id})
    else
      return Router.routes['tree.view.fullscreenViewer'].url({slug: @slug})

Template.gistViewer.helpers
  gistData: ->
    Session.get 'gistData'

Template.gistFullscreenViewer.helpers
  gistData: ->
    Session.get 'gistData'

Template.viewer.events
  'click #shareButton': (event) ->
    $('#sharemodal').modal 'show'
