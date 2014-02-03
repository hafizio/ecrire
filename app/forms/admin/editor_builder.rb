module Admin
  class EditorBuilder < ActionView::Helpers::FormBuilder

    def editor
      [
        editor_options,
        content_tag(:div, class: %w(main editor)) do
          [
            editor_content,
            content_tag(:div, preview, id: "editorSideContent")
          ].join.html_safe
        end
      ].join.html_safe
    end

    protected

    def preview
      content_tag(:div, id: 'contentPreviewContainer') do
        [
          content_tag(:style, nil, id: 'articleStylesheetContent'),
          content_tag(:script, nil, class: %w(preview), id: 'articleScriptContent', type: 'text/javascript'),
          content_tag(:article, nil, class: %w(preview content), id: 'articleHTMLContent'),
        ].join.html_safe
      end
    end

    def editor_options
      content_tag :div, class: %w(wrapper editor options) do
        Options.new(@template, object).render
      end
    end

    def editor_content
      content_tag :div, class: %w(content wrapper) do
        [
          text_area(:content, placeholder: t('.content'), class: %w(content editor), id: 'formContentInput'),
          text_area(:stylesheet, placeholder: t('.stylesheet'), class: %w(stylesheet hidden editor), id: 'formStylesheetInput'),
          text_area(:javascript, placeholder: t('.javascript'), class: %w(javascript hidden editor), id: 'formScriptInput')
        ].join.html_safe
      end
    end

    def t(*args)
      I18n.t args[0], scope: %w(admin form post)
    end

    def method_missing(method, *args, &block)
      @template.send(method, *args, &block)
    end

    class Options

      def initialize(template, object)
        @template = template
        @object = object
      end

      def render
        [
          content_tag(:div, editor_options, class: %w(editor options)),
          content_tag(:div, preview_options, class: %w(preview options))
        ].join.html_safe
      end

      def editor_options
        [
          content_tag(:a, t('fields.text'), binding: ".editor.content", class: %w(content active)),
          content_tag(:a, t('fields.CSS'), binding: ".editor.stylesheet", class: %w(content)),
          content_tag(:a, t('fields.JS'), binding: ".editor.javascript", class: %w(content))
        ].join.html_safe
      end

      def preview_options
        options = [
          link_to(t('preview'), 'javascript:void(0)', class: %w(active), id: "previewLink"),
          link_to(t('partials'), admin_partials_path(), id: "partialsListLink", remote: true)
        ]

        if @object.persisted?
          options << link_to(t('images.link'), admin_post_images_path(@object), id: "imagesListLink", remote: true)
        else
          options << content_tag(:span, t('images.post_not_persisted'), class: %w(disabled))
        end

        options.join.html_safe
      end

      def t(*args)
        I18n.t args[0], scope: %w(admin form post options)
      end

      def method_missing(method, *args, &block)
        @template.send(method, *args, &block)
      end
    end

  end
end
