module Admin
  class PostBuilder < Admin::EditorBuilder

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
      content_tag :div, id: "post_title_wrapper", class: %w(title wrapper) do
        [
          text_field(:title, placeholder: t('.title'), class: %w(input)),
          content_tag(:a, nil, class: %w(toggle entypo-link)),
          text_field(:slug, placeholder: t('.slug'), class: %w(input hidden)),
          possible_actions
        ].join.html_safe
      end
    end

    protected

    def possible_actions
      content_tag :div, class: %w(possible save actions) do
        if object.draft?
          [
            content_tag(:div, class: %w(wrapper)) do
              [
                save_button,
                publish_button
              ].join.html_safe
            end,
            content_tag(:span, '&#59228;'.html_safe, class: %w(arrow))
          ].join.html_safe
        else
          content_tag(:div, save_button, class: %w(wrapper standalone))
        end
      end
    end

    def save_button
      button("Save", name: "admin_post[status]", value: "draft", class: %w(button))
    end

    def publish_button
      button("Publish", name: "admin_post[status]", value: "publish", class: %w(button hidden))
    end

  end
end
