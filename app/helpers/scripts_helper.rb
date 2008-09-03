module ScriptsHelper
  def link_to_script_name(script)
    link_to(h(script.name), users_script_url(:username => script.user.login, :name => script.name))
  end

  def link_to_script_description(script)
    link_to(h(script.description), users_script_url(:username => script.user.login, :name => script.name))
  end

  def script_name(script)
    name = link_to_script_name(script)

    if @all_scripts
      name << "<span class=\"username\"> (#{link_to(h(script.user.login), username_url(script.user.login))})</span>"
    end

    "<div class=\"name\">#{name}</div>"
  end

  def script_actions(script)
    "<div class=\"actions\">#{link_to 'edit', edit_script_path(script)} | #{link_to 'delete', script_path(script), :confirm => "Are you sure?", :method => :delete}</div>"
	end

	def script_time(script)
	  "<div class=\"time\">#{time_ago_in_words(script.updated_at)} ago</div>"
  end

  def script_description(script)
		"<div class=\"description\">#{h(script.description)}</div>"
  end
end
