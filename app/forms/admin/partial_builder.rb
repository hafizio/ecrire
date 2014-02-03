module Admin
  class PartialBuilder < Admin::EditorBuilder

    def errors
      return unless object.errors.any?
      content_tag :div, class: %w(container errors) do
        [
          content_tag(:span, h(object.errors.full_messages.to_sentence)),
          link_to("x", "javascript:void(0)", class: %w(dismiss button))
        ].join.html_safe
      end
    end

    def title
      content_tag :div, id: "partial_title_wrapper", class: %w(title wrapper) do
        [
          text_field(:title, placeholder: t('.title'), class: %w(input)),
          possible_actions
        ].join.html_safe
      end
    end

    protected

    def possible_actions
      content_tag :div, class: %w(possible save actions) do
        content_tag(:div, save_button, class: %w(wrapper standalone))
      end
    end

    def save_button
      button("Save", name: "post[status]", value: "draft", class: %w(button))
    end
  end
end
