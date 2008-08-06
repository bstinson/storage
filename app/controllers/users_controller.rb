class UsersController < ApplicationController
  before_filter :authenticate, :except => [ :index, :logout]

    def index
      # Checks to see if user is already logged in, if so, it redirects them away from login page.
      if session[:user_id]
        @user = User.find_by_id(session[:user_id])
        redirect_to :controller => "index", :action => "index", :company_id => @user.company_id
      else
        # Checks to see if user has already submitted username and password, if so, will attempt to log them in.
        if request.post? and params[:user]
          @user = User.new(params[:user])
          user = User.find_by_name_and_password(@user.name,@user.password)
          if user
            session[:user_id] = user.id
            @user = User.find_by_id(session[:user_id])
            redirect_to :controller => "index", :action => "index", :company_id => @user.company_id
          else
            #Don't show the password in the view
            @user.password = nil
            flash[:notice] = "Invalid screen name/password combination!"
          end
        end
      end
    end

    def logout
      session[:user_id] = nil
      redirect_to :controller => "users"
    end

  # Controllers for user account administration.

    def list_users
      @users = User.find(:all)
    end

    def add
      @companies = Company.find(:all)
      if request.post? and params[:user]
        @user = User.new(params[:user])
        if @user.save
          redirect_to :controller => "users", :action => "list_users"
        end
      end
    end

    def show_user
      @user = User.find(params[:id])
    end  

    def password_change
      @user = User.find(params[:id])
      if request.post? and params[:user]
        if @user.update_attributes(params[:user])
          flash[:notice] = "Password Updated!"
          redirect_to :action => "show_user", :id => @user
        end
      else
      #For security reasons never show the password in a form.
      @user.clear_password!
      render :partial => "password_change"
      end
    end
    
    def delete
        @user = User.find(params[:id])
        @user.destroy
        redirect_to :action => "list_users"   
    end
  protected
    
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == "admin" && password == "storage"
      end
    end
end
