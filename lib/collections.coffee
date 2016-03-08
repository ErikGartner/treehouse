@Trees = new Mongo.Collection 'trees'
@Schemas = {}

Schemas.tree = new SimpleSchema
  name:
    type: String
    label: 'Name'
    min: 3
    max: 30

  owner:
    type: String
    label: 'Owner ID'
    autoValue: ->
      if @isInsert
        return Meteor.userId()

  writekey:
    type: String
    label: 'Key'
    autoValue: ->
      if @isInsert
        return Random.secret()

  data:
    type: String
    label: 'Json data'
    max: 50000

  textTemplate:
    type: String
    optional: true
    label: 'Custom text template (handlerbars)'
    max: 5000

  stylesheet:
    type: String
    label: 'CSS stylesheet'
    max: 10000

  description:
    label: 'Description (markdown)'
    type: String
    max: 10000

  dTreeVersion:
    type: String
    autoValue: ->
      if @isInsert
        return dTree.VERSION

Trees.attachSchema Schemas.tree

Trees.allow(
  insert: (userId, doc) ->
    return userId

  update: (userId, doc, fields, modifier) ->
    if userId == doc.owner
      return true

    if doc.writekey == modifier.$set.writekey
      return true

    return false

  remove: (userId, doc) ->
    return userId == doc.owner
)

Trees.friendlySlugs
  slugFrom: 'name'
  slugField: 'slug'
  distinct: true
  updateSlug: false
