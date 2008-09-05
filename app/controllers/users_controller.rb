class UsersController < ApplicationController
  before_filter :login_required, :only => [ :show, :edit, :update ]
    
  def new
    @user = User.new
  end
  
  def show
    @user = current_user
  end
  
  def edit
    @user = current_user
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.terms_of_service = params[:user][:terms_of_service]
    success = @user && @user.save
    
    if success && @user.errors.empty?
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
      redirect_to login_path
    else
      render :action => 'new'
    end
  end

  def update
    @user = User.find(current_user)
    
    attributes_to_update = {}
    attributes_to_update[:login] = params[:user][:login] unless params[:user][:login] == @user.login
    attributes_to_update[:email] = params[:user][:email] unless params[:user][:email] == @user.email
    attributes_to_update[:password] = params[:user][:password] unless params[:user][:password].nil?
    attributes_to_update[:password_confirmation] = params[:user][:password_confirmation] unless params[:user][:password].nil?
    
    if @user.update_attributes(attributes_to_update)
      flash[:notice] = 'user information updated'
    end
    
    render :action => 'edit'
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please login to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end
end
