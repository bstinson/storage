class CompaniesController < ApplicationController
before_filter :protect  
  def add
    if request.post? and params[:company]
      @company = Company.new(params[:company])
      if @company.save
        redirect_to :action => "index"
      end
    end
  end
  
  def index
    @user = User.find_by_id(session[:user_id])
    @companies = Company.find(:all)
  end
  
  protected

    def protect
      if session[:user_id].nil?
        redirect_to :controller => "users"
        return false
      end
    end
end
