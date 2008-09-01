# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def errors_for(model)
    if(model and model.errors.count > 0)
      error_messages = model.errors.full_messages.map{|msg| content_tag(:li, msg)}
      content_tag(:div, content_tag(:ul, error_messages), :class => 'errors' )
    else
      ''
    end
  end
end
