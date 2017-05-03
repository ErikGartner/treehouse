Router.configure
  layoutTemplate: 'ApplicationLayout'

Router.route '/', ->
  GAnalytics.pageview()
  @render('home')

Router.route '/g/:gist',
  name: 'tree.view.gist',

  data: ->
    return {gist: @params.gist}

  action: ->
    GAnalytics.pageview()
    @render 'gistViewer'

Router.route '/g/f/:gist',
  name: 'tree.view.fullscreenGist'

  data: ->
    return {gist: @params.gist}

  action: ->
    GAnalytics.pageview()
    @render 'gistFullscreenViewer'

Router.route '/:username/:gist',
  name: 'tree.view.shortUrlGist'
  data: ->
    GAnalytics.pageview()
    return {gist: @params.gist}

  action: ->
    @render 'gistViewer'
