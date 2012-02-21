module ApplicationHelper

  def attribute_tag(attribute, value_object = nil)
    result = ""
    result << label_tag("attribute#{attribute.id}", attribute.title)
    value = value_object ? value_object.value : nil
    result << send("attribute_tag_#{attribute.kind}", attribute, value)
  end

  def attribute_tag_string attribute, value
    text_field_tag "attribute#{attribute.id}", value
  end

  def attribute_tag_boolean attribute, value
    check_box_tag "attribute#{attribute.id}", 1, value
  end

end
