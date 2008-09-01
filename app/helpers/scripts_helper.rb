module ScriptsHelper
  def script_name(script)
    name = link_to(h(script.name), script_by_username_url(:username => script.user.login, :name => script.name))
    user = ''
    time = ''
    
    if @all_scripts
      user = "<span class=\"username\"> (#{link_to(h(script.user.login), username_url(:username => script.user.login))})</span>"
    end
    
    name << user
  end
end
