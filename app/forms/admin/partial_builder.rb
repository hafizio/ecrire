module Admin
  class PartialBuilder < ActionView::Helpers::FormBuilder

    def title
      content_tag :div, id: "partial_title_wrapper", class: %w(title wrapper) do
        [
          text_field(:title, placeholder: t('.title'), class: %w(input)),
          possible_actions
        ].join.html_safe
      end
    end

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
      content_tag(:div, class: %w(content preview)) do
        [
          content_tag(:span, t('.preview'), class: %w(sticky)),
          content_tag(:style),
          content_tag(:script, nil, class: %w(preview), type: 'text/javascript'),
          content_tag(:div, nil, class: %w(preview)),
        ].join.html_safe
      end
    end

    def editor_options
      content_tag :div, class: %w(editor options wrapper) do
        Options.new(@template).render
      end
    end

    def editor_content
      content_tag :div, class: %w(content wrapper) do
        [
          text_area(:content, placeholder: t('.content'), class: %w(content editor)),
          text_area(:stylesheet, placeholder: t('.stylesheet'), class: %w(stylesheet hidden editor)),
          text_area(:javascript, placeholder: t('.javascript'), class: %w(javascript hidden editor))
        ].join.html_safe
      end
    end

    def possible_actions
      content_tag :div, class: %w(possible save actions) do
        content_tag(:div, save_button, class: %w(wrapper standalone))
      end
    end

    def save_button
      button("Save", name: "post[status]", value: "draft", class: %w(button))
    end

    def method_missing(method, *args, &block)
      @template.send(method, *args, &block)
    end

    class Options

      def initialize(template)
        @template = template
      end

      def render
        content_tag(:div, editor_options, class: %w(editor options))
      end

      def editor_options
        [
          content_tag(:a, t('.text'), binding: ".editor.content", class: %w(content active)),
          content_tag(:a, t('.CSS'), binding: ".editor.stylesheet", class: %w(content)),
          content_tag(:a, t('.JS'), binding: ".editor.javascript", class: %w(content))
        ].join.html_safe
      end

      def method_missing(method, *args, &block)
        @template.send(method, *args, &block)
      end
    end

  end
end