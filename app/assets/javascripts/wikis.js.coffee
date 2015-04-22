# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  opts = {
    container: 'epiceditor',
    textarea: 'body',
    clientSideStorage: false,
    basePath: '/assets/',
    button: {
      preview: true,
      fullscreen: false,
      bar: "auto"
    },
    theme: {
      base: '/epiceditor.css',
      preview: '/github.css',
      editor: '/epic-dark.css'
    },
  }
  editor = new EpicEditor(opts).load()
