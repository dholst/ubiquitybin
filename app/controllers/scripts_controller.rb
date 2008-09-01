class ScriptsController < ApplicationController
  before_filter :login_required, :except => [ :index, :show ]
  
  def index
    @my_scripts = @all_scripts = false
    
    if params[:username]
      @username = params[:username]
      user = User.find_by_login(@username)
      
      if(!user)
        render :text => 'Not Found', :status => 404
        return
      end
      
      @my_scripts = logged_in? && current_user == user
      @scripts = Script.paginate_by_user_id user.id, :page => params[:page], :order => 'name ASC'
    else
      @all_scripts = true
      @scripts = Script.paginate :page => params[:page], :order => 'updated_at DESC' 
    end
  end
  
  def create
    @script = Script.new(params[:script])
    @script.user_id = current_user.id
    
    if( @script.save )
      redirect_to username_path(:username => current_user.login)
    else
      render :action => :new
    end
  end
  
  def show
    if(params[:username] && params[:name])
      @script = Script.find_by_user_id_and_name(User.find_by_login(params[:username]).id, params[:name])
    else
      @script = Script.find(params[:id])
    end
  end
end
