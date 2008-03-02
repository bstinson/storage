class IndexController < ApplicationController
  def index
    @user = User.find_by_id(session[:user_id])
    if params[:company_id]      
      @company_id = Company.find_by_id(params[:company_id])
    else
      @company_id = Company.find_by_id(@user.company_id)
    end
    @companies = Company.find(:all)
    flash[:notice] = "Welcome to your application's home page! This is where you can get a quick view of what sheds our open for your buildings, or get links to further actions that you can take. Enjoi."
    @buildings = Building.find_all_by_company_id(@company_id, :order => 'name ASC')
    @units = Unit.find_all_by_id(@company_id.id)
    @vacant_units = Unit.find_all_by_id_and_status(@company_id.id, 'Vacant')
    @occupied_units = Unit.find_all_by_id_and_status(@company_id.id, 'Occupied')
    @unclean_units = Unit.find_all_by_id_and_status(@company_id.id, 'Needs Cleaning')
    @damaged_units = Unit.find_all_by_id_and_status(@company_id.id, 'Damaged')
    @locked_units = Unit.find_all_by_id_and_status(@company_id.id, 'Locked Out')


  end
  
  def update_building
    @user = User.find_by_id(session[:user_id])
    @building = Building.find_by_id(params[:building_id])
    @units = Unit.find_all_by_building_id(params[:building_id])
    render :partial => "update_building"
  end

  def view_unit
    @user = User.find_by_id(session[:user_id])
    @company_id = User.find_by_id(@user.company_id)
    @companies = Company.find(:all)
    flash[:notice] = "Here is where you can view information on a unit, and also update its information."
    @buildings = Building.find_all_by_company_id(@user.company_id)
    @unit = Unit.find_by_id(params[:id])
  end
end