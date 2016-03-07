AutoForm.addHooks 'editTreeForm',
  before:
    update: (doc) ->
      doc.$set.writekey = Router.current().params.key
      return doc
