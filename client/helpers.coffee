Template.registerHelper 'appVersion', ->
  return Meteor.settings.public.treehouse?.version
