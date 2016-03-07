Meteor.publish 'trees', ->
  Trees.find {}, {fields: {writekey: 0}}

Meteor.publish 'myTrees', ->
  Trees.find owner: @userId
