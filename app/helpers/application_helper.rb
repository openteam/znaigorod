module ApplicationHelper

  def attribute_tag(attribute, value_object = nil)
    result = ''
    result << '<li>'
    result << label_tag("attribute#{attribute.id}", attribute.title)
    result << '<abbr>*</abbr>' if attribute.required
    result << send("attribute_tag_#{attribute.kind}", attribute, value_object ? value_object.value : nil)
    result << "<span class='inline_errors'>#{value_object.errors.messages[:value].join(', ')}</span>" if value_object.errors and value_object.errors.any?
    result << '</li>'
  end

  def attribute_value_tag(attribute, value_object = nil)
    result = ''
    result << '<li>'
    result << label_tag("attribute#{attribute.id}", attribute.title + ":")
    result << "<span><b>#{value_object.value}</b></span>"
    result << '</li>'
  end

  def attribute_tag_string attribute, value
    text_field_tag "attribute[string][#{attribute.id}]", value
  end

  def attribute_tag_boolean attribute, value
    check_box_tag "attribute[boolean][#{attribute.id}]", 1, value
  end

end
