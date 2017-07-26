inputs = %w[
CollectionSelectInput
DateTimeInput
FileInput
GroupedCollectionSelectInput
NumericInput
PasswordInput
RangeInput
StringInput
TextInput
]
inputs.each do |input_type|
  superclass = "SimpleForm::Inputs::#{input_type}".constantize
  new_class = Class.new(superclass) do
    def input_html_classes
      super.push('form-control')
    end
  end
  Object.const_set(input_type, new_class)
end
# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.boolean_style = :nested
#  config.wrappers :bootstrap3, tag: 'div', class: 'form-group', error_class: 'has-error',
#  defaults: { input_html: { class: 'default_class' } } do |b|
  config.wrappers :bootstrap3, tag: 'div', class: 'form-group label-floating', error_class: 'has-error' do |b|
    b.use :html5
    b.use :min_max
    b.use :maxlength
    b.use :placeholder
    b.optional :pattern
    b.optional :readonly
    b.use :label
#    b.wrapper :input_wrapper, tag: 'div', class: :"input-group" do |ba|
      b.use :input
      b.use :hint, wrap_with: { tag: 'span', class: 'help-block' }
      b.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
#    end
  end
#  config.wrappers :prepend, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
#    b.use :html5
#    b.use :placeholder
#    b.wrapper tag: 'div', class: 'controls' do |input|
#      input.wrapper tag: 'div', class: 'input-group' do |prepend|
#        prepend.use :label , class: 'input-group-addon' ###Please note setting class here fro the label does not currently work (let me know if you know a workaround as this is the final hurdle)
#        prepend.use :input
#      end
#      input.use :hint, wrap_with: { tag: 'span', class: 'help-block' }
#      input.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
#    end
#  end
#  config.wrappers :append, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
#    b.use :html5
#    b.use :placeholder
#    b.wrapper tag: 'div', class: 'controls' do |input|
#      input.wrapper tag: 'div', class: 'input-group' do |prepend|
#        prepend.use :input
#        prepend.use :label , class: 'input-group-addon' ###Please note setting class here fro the label does not currently work (let me know if you know a workaround as this is the final hurdle)
#      end
#      input.use :hint, wrap_with: { tag: 'span', class: 'help-block' }
#      input.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
#    end
#  end

  config.wrappers :checkbox, tag: :div, class: "form-group checkbox", error_class: "has-error", defaults: { input_html: { class: 'default_class' } } do |b|

    # Form extensions
    b.use :html5
    b.use :label

    # Form components
#    b.wrapper :input_wrapper, tag: :div, class: :"input-group" do |ba|
      b.use :input
      b.use :hint, wrap_with: { tag: 'span', class: 'help-block' }
      b.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }

#      ba.use :label_text
#    end

  end

  config.wrappers :file, tag: :div, class: 'form-group label-floating', error_class: 'has-error' do |f|
    f.use :html5
    f.use :label
    f.use :input, type: :file

    f.wrapper :input_wrapper, tag: :div, class: :"input-group" do |i|
      i.use :input, type: :text, readonly: "", name: nil, id: nil, class: "form-control"
      i.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
      i.wrapper :input_group, tag: :span, class: ["input-group-btn", "input-group-sm"] do |s|
        s.wrapper :button, tag: :button, type: :button, class: ["btn", "btn-info", "btn-fab", "btn-fab-mini"] do |b|
          b.wrapper :icon, tag: :i, class: ["glyphicon", "glyphicon-paperclip"] do end
        end
      end
    end
  end
  # Wrappers for forms and inputs using the Twitter Bootstrap toolkit.
  # Check the Bootstrap docs (http://getbootstrap.com/)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.default_wrapper = :bootstrap3
end