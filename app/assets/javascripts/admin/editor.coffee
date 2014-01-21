$(document).on "DOMContentLoaded page:load", ->
  if $(".editor.form").length > 0
    window.Editor = new Editor()

    $(".editor.options").on "click", "a.content", ->
      $this = $(this)
      $this.siblings(".active").removeClass("active")
      $this.addClass("active")
      $el = $($this.attr("binding"))
      $(".content > .editor").not($el).hide()
      $el.show()

    $(".preview.options").on 'click', 'a', ->
      $this = $(this)
      $this.siblings(".active").removeClass("active")
      $this.addClass("active")

    $(".preview.options #previewLink").on 'click', (e) ->
      window.Editor.sidebarContent.show('preview')

    $(document).trigger('editor:loaded', window.Editor)

class Editor
  constructor: (opts) ->
    elements = {
      $content: $(".editor.content"),
      $stylesheet: $(".editor.stylesheet"),
      $preview: $("#contentPreviewContainer"),
    }

    @title =  new Title()
    @menu = new SaveButton($(".possible.save.actions"))
    @sidebarContent = new SideBarContent($("#editorSideContent"))
    @listen(elements)

  listen: (elements) ->
    sidebarContent = @sidebarContent
    $textareas = elements.$content.add(elements.$preview)
    updatePreview = ->
      $preview = elements.$preview.children(".preview")
      $preview.html elements.$content.val()
      $preview.find('link[rel="partial"]').each ->
        $link = $(this)
        $.get $link.attr('href'), (data) ->
          $link.replaceWith(data)
      elements.$preview.children("style").text elements.$stylesheet.val()
      Prism.highlightAll()

    elements.$content.get(0).addEventListener 'input', updatePreview
    elements.$stylesheet.get(0).addEventListener 'input', updatePreview

    elements.$content.get(0).addEventListener 'scroll', ->
      sidebarContent.scrollTo(this.scrollTop / this.scrollHeight)

    updatePreview()

class SideBarContent
  constructor: ($wrapper) ->
    @$wrapper = $wrapper
    @templates = {}
    @templates['preview'] = $('#contentPreviewContainer')

  show: (name) =>
    @$wrapper.children().detach()
    @$wrapper.html(@templates[name])

  add: (name, dom) =>
    if @templates[name]? 
      raise "Can't add template because another template is assigned to #{name}"
    @templates[name] = dom
    return this

  scrollTo: (percent) ->
    @$wrapper.scrollTop(percent * @$wrapper.get(0).scrollHeight)


class Title
  constructor: ->
    @elements = {
      $wrapper: $(".title.wrapper"),
      $title: $(".title.wrapper > .input"),
      $slug: $("#post_slug")
    }

    @listen(@elements)

  listen: (elements) ->
    elements.$wrapper.on 'click', 'a.toggle', =>
      @toggle(elements)

  toggle: (elements) ->
    elements.$wrapper.toggleClass("slug")
    elements.$title.add(elements.$slug).toggle()

class SaveButton
  constructor: ($el) ->
    $el.on 'click', '.arrow', ->
      $el.find("button[value=publish]").toggle()

