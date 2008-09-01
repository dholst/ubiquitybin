ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag =~ /<(input|textarea|select)/
    class_attribute = html_tag.index('class=\"')
    
    if class_attribute
      html_tag.insert(class_attribute + 7, 'error ')
    else
      html_tag.insert(html_tag.index(' '), ' class="error" ')
    end
    
    html_tag << "<br><span class=\"errors\">#{[instance.error_message].flatten.join(', ')}</span>"
  else
    html_tag
  end
end
