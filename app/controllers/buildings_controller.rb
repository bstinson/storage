class BuildingsController < ApplicationController
layout "admin"
before_filter :protect

  def add
    @companies = Company.find(:all)
    @user = User.find_by_id(session[:user_id])
    if request.post? and params[:building]
      @building = Building.new(params[:building])
      if @building.save
        flash[:notice] = "Successfully created user!"
        redirect_to :action => 'index'
      end
    end    
  end
  
  def index
    @companies = Company.find(:all)
    @user = User.find_by_id(session[:user_id])
    @buildings = Building.find_all_by_company_id(@user.company_id)
  end
  
  protected

    def protect
      if session[:user_id].nil?
        redirect_to :controller => "users"
        return false
      end
    end
end
