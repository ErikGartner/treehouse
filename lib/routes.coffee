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
    @render 'viewer'

Router.route '/t/:slug/:key',
  name: 'tree.view.owner',
  waitOn: ->
    return Meteor.subscribe 'trees'

  data: ->
    return Trees.findOne slug: @params.slug

  action: ->
    @render 'viewer'

Router.route '/f/:slug',
  name: 'tree.view.fullscreen',
  waitOn: ->
    return Meteor.subscribe 'trees'

  data: ->
    return Trees.findOne slug: @params.slug

  action: ->
    @render 'fullscreenViewer'

Router.route '/t/:slug/:key/edit',
  name: 'tree.editor',
  waitOn: ->
    return Meteor.subscribe 'trees'

  data: ->
    return Trees.findOne slug: @params.slug

  action: ->
    @render 'editor'
