class IndexController < ApplicationController
  before_filter :protect
  
  def index
    @user = User.find_by_id(session[:user_id])
    if params[:company_id]      
      @company_id = Company.find_by_id(params[:company_id])
    else
      @company_id = Company.find_by_id(@user.company_id)
    end
    @companies = Company.find(:all)
    if flash[:notice] = ""
      flash[:notice] = "Welcome to your application's home page! This is where you can get a quick view of what sheds our open for your buildings, or get links to further actions that you can take. Enjoi."
    end
    @buildings = Building.find_all_by_company_id(@company_id, :order => 'name ASC')
    @units = Unit.find_all_by_company_id(@company_id.id, :order => 'unit_num ASC')
    @vacant_units = Unit.find_all_by_company_id_and_status(@company_id.id, 'Vacant')
    @occupied_units = Unit.find_all_by_company_id_and_status(@company_id.id, 'Occupied')
    @unclean_units = Unit.find_all_by_company_id_and_status(@company_id.id, 'Unclean')
    @damaged_units = Unit.find_all_by_company_id_and_status(@company_id.id, 'Damaged')
    @locked_units = Unit.find_all_by_company_id_and_status(@company_id.id, 'Locked')
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
    if flash[:notice] == nil
      flash[:notice] = "Here is where you can view information on a unit, and also update its information."
    end
    @buildings = Building.find_all_by_company_id(@user.company_id)
    @unit = Unit.find_by_id(params[:id])
    @notes = Note.find_all_by_unit_id(@unit.id, :order => "created_at DESC")
    @notes_count = Note.count(:conditions => "unit_id = " + @unit.id.to_s )

  end
  
  def add_customer
    @user = User.find_by_id(session[:user_id])
    @companies = Company.find(:all)
    @company_id = User.find_by_id(@user.company_id)
    @unit = Unit.find(params[:id])
    flash[:notice] = "Here is where you can add a customer to a unit."
    if request.post? and params[:unit]
        if @unit.update_attributes(params[:unit])
          StatusChange.deliver_added(@unit)
          flash[:notice] = "Customer Added!"
          redirect_to :action => "view_unit", :id => @unit
        end
      else
        @unit = Unit.find_by_id(params[:id])
    end
  end
  
  def edit_customer
    @user = User.find_by_id(session[:user_id])
    @companies = Company.find(:all)
    @company_id = User.find_by_id(@user.company_id)
    @unit = Unit.find(params[:id])
    flash[:notice] = "Here is where you can add a customer to a unit."
    if request.post? and params[:unit]
        if @unit.update_attributes(params[:unit])
          StatusChange.deliver_status(@unit)
          flash[:notice] = "Customer Updated!"
          redirect_to :action => "view_unit", :id => @unit
        end
      else
      @unit = Unit.find_by_id(params[:id])
    end
  end  
 
  def remove_customer
    @unit = Unit.find_by_id(params[:id])
    StatusChange.deliver_cleared(@unit)                            
    if @unit.update_attributes( :status => "Vacant",
                                :name => nil,
                                :ssn => nil,
                                :dl => nil,
                                :address => nil,
                                :city => nil,
                                :state => nil,
                                :zip => nil,
                                :phone => nil,
                                :work_cell => nil,
                                :email => nil,
                                :alt_contact => nil,
                                :alt_phone => nil,
                                :auth_users => nil,
                                :monthly_price => nil,
                                :code => nil)
      flash[:notice] = "Customer has been removed!"                            
      redirect_to :action => "index"
    else
      redirect_to :action => "view_unit", :id => @unit
    end
  end
    
  def contract
    @unit = Unit.find(params[:id])
    @company = Company.find_by_id(@unit.company_id)
    render(:layout => "layouts/contract")
  end
  
  def add_note
    @unit = Unit.find(params[:id])
    if request.post? and params[:note]
      @note = Note.new(params[:note])
      if @note.save
        redirect_to :action => "view_unit", :id => @unit
      end
    else
      render :partial => "add_note"   
    end
  end
  
  protected

    def protect
      if session[:user_id].nil?
        redirect_to :controller => "users"
        return false
      end
    end
end