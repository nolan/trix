trix.testGroup "Attachments", template: "editor_with_image", ->
  trix.test "moving an image by drag and drop", (expectDocument) ->
    trix.typeCharacters "!", ->
      trix.moveCursor direction: "right", times: 1, (coordinates) ->
        img = document.activeElement.querySelector("img")
        trix.triggerEvent(img, "mousedown")
        trix.defer ->
          trix.dragToCoordinates coordinates, ->
            expectDocument "!a#{Trix.OBJECT_REPLACEMENT_CHARACTER}b\n"

  trix.test "removing an image", (expectDocument) ->
    trix.after 20, ->
      trix.clickElement getFigure(), ->
        closeButton = getFigure().querySelector(".#{Trix.config.css.classNames.attachment.removeButton}")
        trix.clickElement closeButton, ->
          expectDocument "ab\n"

  trix.test "editing an image caption", (expectDocument) ->
    trix.after 20, ->
      trix.clickElement findElement("figure"), ->
        trix.clickElement findElement("figcaption"), ->
          trix.defer ->
            trix.assert.ok findElement("textarea")
            findElement("textarea").focus()
            findElement("textarea").value = "my caption"
            trix.pressKey "return", ->
              trix.assert.notOk findElement("textarea")
              trix.assert.textAttributes [2, 3], caption: "my caption"
              expectDocument "ab#{Trix.OBJECT_REPLACEMENT_CHARACTER}\n"

getFigure = ->
  findElement("figure")

findElement = (selector) ->
  getEditorElement().querySelector(selector)
