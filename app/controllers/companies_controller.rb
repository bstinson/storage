class CompaniesController < ApplicationController

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

end
