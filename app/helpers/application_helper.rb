module ApplicationHelper

  KIND_CLASSES = {
      'boolean' => 'ym-fbox-check',
      'string' => 'ym-fbox-text'
  }

  def parameter_tag(parameter, value_object = nil)
    result = ''
    result << "<li class = '#{KIND_CLASSES[parameter.kind]}'>"
    result << "<label for='parameter#{parameter.id}'>#{parameter.title}"
    result << '<abbr>*</abbr>' if parameter.required
    result << "</label>"
    result << send("parameter_tag_#{parameter.kind}", parameter, value_object ? value_object.value : nil)
    result << "<span class='inline_errors'>#{value_object.errors.messages[:value].join(', ')}</span>" if value_object.errors and value_object.errors.any?
    result << '</li>'
  end

  def parameter_value_tag(parameter, value_object = nil)
    result = ''
    result << '<li>'
    result << label_tag("parameter#{parameter.id}", parameter.title + ":")
    result << "<span><b>#{value_object.value}</b></span>"
    result << '</li>'
  end

  def parameter_tag_string parameter, value
    text_field_tag "parameter[string][#{parameter.id}]", value
  end

  def parameter_tag_boolean parameter, value
    check_box_tag "parameter[boolean][#{parameter.id}]", 1, value
  end

end
