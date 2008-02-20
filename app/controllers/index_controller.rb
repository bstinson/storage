class IndexController < ApplicationController
  def index
    @user = User.find_by_id(session[:user_id])
    @companies = Company.find(:all)
  end
end
