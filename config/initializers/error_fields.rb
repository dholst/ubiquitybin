ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag =~ /<label.*terms_of_service/ || (html_tag =~ /<(input|textarea|select)/ && !html_tag.index('type="hidden"') && !html_tag.index('type="checkbox"'))
    if !html_tag.index('<label')
      class_attribute = html_tag.index('class=\"')
    
      if class_attribute
        html_tag.insert(class_attribute + 7, 'error ')
      else
        html_tag.insert(html_tag.index(' '), ' class="error" ')
      end
    end
    
    errors = [instance.error_message].flatten
    html_tag << "<br><span title=\"#{errors.join(', ')}\" class=\"errors\">#{errors.first}</span>"
  else
    html_tag
  end
end
