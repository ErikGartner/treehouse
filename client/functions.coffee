@getGist = (gistId, callback) ->
  url = 'https://api.github.com/gists/' + gistId
  HTTP.get url, (err, res) ->
    if err?
      callback(err, res)
      return

    gist = JSON.parse res.content

    data =
      gist: gist
      name: gist.description
      data: gist.files['data.json']?.content
      description: gist.files['readme.md']?.content
      stylesheet: gist.files['stylesheet.css']?.content
      textRenderer: gist.files['renderer.handlebars']?.content

    callback(err, data)

  return
