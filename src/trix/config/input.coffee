Trix.config.input =
  level2Enabled: true

  getLevel: ->
    if @level2Enabled and Trix.browser.supportsInputEvents
      2
    else
      0

  pickFiles: (callback) ->
    input = Trix.makeElement("input", type: "file", multiple: true, hidden: true, id: @fileInputId, accept: "image/*")

    input.addEventListener "change", ->
      callback(input.files)
      Trix.removeNode(input)

    Trix.removeNode(document.getElementById(@fileInputId))
    document.body.appendChild(input)
    input.click()

  fileInputId: "trix-file-input-#{Date.now().toString(16)}"
