# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def focus_on(value)
    "<script type=\"text/javascript\">document.getElementById('#{value}').focus();</script>"
  end
end
