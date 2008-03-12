class UnitsController < ApplicationController
layout "admin"
before_filter :protect
  def index
    @user = User.find_by_id(session[:user_id])
    @companies = Company.find(:all)
    @buildings = Building.find_all_by_company_id(@user.company_id, :order => "name ASC")
    flash[:notice] = "This is where you can see what units are available and also, you have the ability to add Units to your buildings. This probably won't be seen by anyone, except for an administrator."
  end
  
  def add 
    @user = User.find_by_id(session[:user_id])
    @companies = Company.find(:all)
    @buildings = Building.find_all_by_company_id(@user.company_id)
    flash[:notice] = "Here is where you can add a unit to a building"  
    
    if request.post? and params[:unit]
      @unit = Unit.new(params[:unit])
      if @unit.save
        flash[:notice] = "Successfully added unit!"
        redirect_to :action => 'index'
      end
    end
  end
  
  def edit
    @user = User.find_by_id(session[:user_id])
    @companies = Company.find(:all)
    flash[:notice] = "Tst"    
  end
  
  protected

    def protect
      if session[:user_id].nil?
        redirect_to :controller => "users"
        return false
      end
    end  
end
