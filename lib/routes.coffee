Router.configure
  layoutTemplate: 'ApplicationLayout'

Router.route '/', ->
  @render('home')

Router.route '/create', ->
  @render('create')

Router.route '/t/:slug',
  name: 'tree.view.guest',
  waitOn: ->
    return Meteor.subscribe 'trees'

  data: ->
    return Trees.findOne slug: @params.slug

  action: ->
    @render 'localViewer'

Router.route '/t/:slug/:key',
  name: 'tree.view.owner',
  waitOn: ->
    return Meteor.subscribe 'trees'

  data: ->
    return Trees.findOne slug: @params.slug

  action: ->
    @render 'localViewer'

Router.route '/f/:slug',
  name: 'tree.view.fullscreenViewer',
  waitOn: ->
    return Meteor.subscribe 'trees'

  data: ->
    return Trees.findOne slug: @params.slug

  action: ->
    @render 'localFullscreenViewer'

Router.route '/t/:slug/:key/edit',
  name: 'tree.editor',
  waitOn: ->
    return Meteor.subscribe 'trees'

  data: ->
    return Trees.findOne slug: @params.slug

  action: ->
    @render 'editor'

Router.route '/g/:gist',
  name: 'tree.view.gist',

  data: ->
    return {gist: @params.gist}

  action: ->
    @render 'gistViewer'

Router.route '/g/f/:gist',
  name: 'tree.view.fullscreenGist'

  data: ->
    return {gist: @params.gist}

  action: ->
    @render 'gistFullscreenViewer'
