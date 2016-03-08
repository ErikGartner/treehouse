AutoForm.addHooks 'editTreeForm',
  before:
    update: (doc) ->
      doc.$set.writekey = Router.current().params.key
      return doc

codeMirrorInit = ->
  opts =
    lineNumbers: true

  opts.mode = 'markdown'
  CodeMirror.fromTextArea $('[name="description"]').get(0), opts
  opts.mode = 'css'
  CodeMirror.fromTextArea $('[name="stylesheet"]').get(0), opts
  opts.mode = {name: 'javascript', json: true}
  CodeMirror.fromTextArea $('[name="data"]').get(0), opts
  opts.mode = mode: {name: 'handlebars', base: 'text/html'}
  CodeMirror.fromTextArea $('[name="textTemplate"]').get(0), opts

Template.editor.onRendered ->
  codeMirrorInit()

Template.create.onRendered ->
  codeMirrorInit()
