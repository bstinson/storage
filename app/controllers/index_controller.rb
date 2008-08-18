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
      flash[:notice] = "Welcome to your application's home page! This is where you can get a quick view of what sheds our open for your buildings, or get links to further actions that you can take. Enjoy!"
    end
    @buildings = Building.find_all_by_company_id(@company_id, :order => 'name ASC')
    @units = Unit.find_all_by_company_id(@company_id.id, :order => 'unit_num ASC')
    @vacant_units = Unit.find_all_by_company_id_and_status(@company_id.id, 'Vacant')
    @occupied_units = Unit.find_all_by_company_id_and_status(@company_id.id, 'Occupied')
    @unclean_units = Unit.find_all_by_company_id_and_status(@company_id.id, 'Unclean')
    @damaged_units = Unit.find_all_by_company_id_and_status(@company_id.id, 'Damaged')
    @late_units = Unit.find_all_by_company_id_and_status(@company_id.id, 'Late')
  end
  
  def update_building
    @user = User.find_by_id(session[:user_id])
    @building = Building.find_by_id(params[:building_id])
    @company_id = Company.find_by_id(@building.company_id)
    @buildings = Building.find_all_by_company_id(@company_id, :order => 'name ASC')         
    @companies = Company.find(:all)
    flash[:notice] = "Welcome to your application's home page! This is where you can get a quick view of what sheds our open for your buildings, or get links to further actions that you can take. Enjoy!"
    @units = Unit.find_all_by_building_id(params[:building_id], :order => 'unit_num ASC')
  end

  def view_unit
    @user = User.find_by_id(session[:user_id])
    @company_id = User.find_by_id(@user.company_id)
    @companies = Company.find(:all)
    if flash[:notice] == nil
      flash[:notice] = "Here is where you can view information on a unit, and also update its information."
    end
    @unit = Unit.find_by_unit_num_and_building_id(params[:unit_num], params[:building_id])
    @notes = Note.find_all_by_unit_id(@unit.id, :order => "created_at DESC")
    @notes_count = Note.count(:conditions => "unit_id = " + @unit.id.to_s )
  end
  
  def add_customer
    @user = User.find_by_id(session[:user_id])
    @companies = Company.find(:all)
    @company_id = User.find_by_id(@user.company_id)
    @unit = Unit.find(params[:id])
    @emails = User.find_all_by_company_id(@user.company_id)
    flash[:notice] = "Here is where you can add a customer to a unit."
    if request.post? and params[:unit]
      @test_unit = Unit.new(params[:unit])
      @previous_customer =  Prevcustomer.find_by_ssn_and_dl_and_phone(@test_unit.ssn, @test_unit.dl, @test_unit.phone)
      if @previous_customer.nil?
        if @unit.update_attributes(params[:unit])
          for email in @emails
            StatusChange.deliver_added(@unit, @user, email.email)
          end
          flash[:notice] = "Customer Added!"
          redirect_to :action => "view_unit", :unit_num => @unit.unit_num, :building_id => @unit.building_id
        end
      else
        redirect_to :action => "view_previous_customer", :prev_id => @previous_customer, :unit_id => @unit, :monthly_price => @test_unit.monthly_price, :deposit => @test_unit.deposit
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
    @emails = User.find_all_by_company_id(@user.company_id)    
    flash[:notice] = "Here is where you can add a customer to a unit."
    if request.post? and params[:unit]
        if @unit.update_attributes(params[:unit])
          for email in @emails      
            StatusChange.deliver_status(@unit, @user, email.email)
          end  
          flash[:notice] = "Customer Updated!"
          redirect_to :action => "view_unit", :unit_num => @unit.unit_num, :building_id => @unit.building_id
        end
      else
      @unit = Unit.find_by_id(params[:id])
    end
  end  

  def change_status
    @user = User.find_by_id(session[:user_id])
    @companies = Company.find(:all)
    @company_id = User.find_by_id(@user.company_id)
    @unit = Unit.find(params[:id])
    @emails = User.find_all_by_company_id(@unit.company_id)        
    flash[:notice] = "Here is where you can change the status of a unit."
    if request.post? and params[:unit]
        if @unit.update_attributes(params[:unit])
          for email in @emails      
            StatusChange.deliver_status(@unit, @user, email.email)
          end  
          flash[:notice] = "Unit Status has been Changed!"
          if @unit.name.nil?
            redirect_to :action => "update_building", :building_id => @unit.building_id
          else  
          redirect_to :action => "view_unit", :unit_num => @unit.unit_num, :building_id => @unit.building_id
          end
        end
      else
      @unit = Unit.find_by_id(params[:id])
    end
  end 
  
  def vacate_notice
    @unit = Unit.find_by_id(params[:id])
    @user = User.find_by_id(params[:user_id])
  end
  
  def remove_customer
    @unit = Unit.find_by_id(params[:id])
    @user = User.find_by_id(params[:user_id])
    @notes = Note.find_all_by_unit_id(@unit.id)
    @emails = User.find_all_by_company_id(@user.company_id)    
    for email in @emails  
      StatusChange.deliver_cleared(@unit, @user, email.email)                            
    end
    @prev_customer = Prevcustomer.new(:name => @unit.name,
                                      :ssn => @unit.ssn,
                                      :dl => @unit.dl,
                                      :address => @unit.address,
                                      :city => @unit.city,
                                      :state => @unit.state,
                                      :zip => @unit.zip,
                                      :phone => @unit.phone,
                                      :work_cell => @unit.work_cell,
                                      :email => @unit.email,
                                      :alt_contact => @unit.alt_contact,
                                      :alt_phone => @unit.alt_phone,
                                      :auth_users => @unit.auth_users,
                                      :code => @unit.code)
    @prev_customer.save
    if @notes != 0
      for note in @notes
        note.update_attributes(:prevcustomer_id => @prev_customer.id,
                               :unit_id => nil)
      end
    end  
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
                                :deposit => nil,
                                :monthly_price => nil,
                                :code => nil)
      flash[:notice] = "Customer has been removed!"                           
      redirect_to :action => "index"
    else
      flash[:notice] = "There has been a problem and the customer has not been removed!"
      redirect_to :action => "view_unit", :unit_num => @unit.unit_num, :building_id => @unit.building_id
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
        flash[:notice] = "Note Added!"
        redirect_to :action => "view_unit", :unit_num => @unit.unit_num, :building_id => @unit.building_id
      end
    else
      render :partial => "add_note"   
    end
  end
  
  def popup 
    @unit = Unit.find_by_building_id_and_unit_num(params[:building_id], params[:unit_num])
    render(:layout => "layouts/popup")    
  end 
  
  def customer_report
    @user = User.find_by_id(session[:user_id])
    @units = Unit.find_all_by_company_id(@user.company_id)
    render(:layout => "layouts/popup")
  end
    
  def view_previous_customer
    flash[:notice] = "You are trying to add a previous customer! Please review their past information and decide whether or not to continue"
    @user = User.find_by_id(session[:user_id])
    @company_id = User.find_by_id(@user.company_id)
    @companies = Company.find(:all)
    @unit = Unit.find_by_id(params[:unit_id])
    @deposit = (params[:deposit])
    @monthly_price = (params[:monthly_price])
    @previous_customer = Prevcustomer.find_by_id(params[:prev_id])
    @notes = Note.find_all_by_prevcustomer_id(@previous_customer.id, :order => "created_at DESC")
    @notes_count = Note.count(:conditions => "prevcustomer_id = " + @previous_customer.id.to_s )  
  end 
  
  def add_previous_customer
    @prev_customer = Prevcustomer.find_by_id(params[:id])
    @unit = Unit.find_by_id(params[:unit_id])
    @deposit = (params[:deposit])
    @monthly_price = (params[:monthly_price])
    @notes = Note.find_all_by_prevcustomer_id(@prev_customer.id, :order => "created_at DESC")
    if request.post?
      if @unit.update_attributes( :status => "Occupied",
                                  :name => @prev_customer.name,
                                  :ssn => @prev_customer.ssn,
                                  :dl => @prev_customer.dl,
                                  :address => @prev_customer.address,
                                  :city => @prev_customer.city,
                                  :state => @prev_customer.state,
                                  :zip => @prev_customer.zip,
                                  :phone => @prev_customer.phone,
                                  :work_cell => @prev_customer.work_cell,
                                  :email => @prev_customer.email,
                                  :alt_contact => @prev_customer.alt_contact,
                                  :alt_phone => @prev_customer.alt_phone,
                                  :auth_users => @prev_customer.auth_users,
                                  :code => @prev_customer.code,
                                  :monthly_price => @monthly_price,
                                  :deposit => @deposit) 
          
          if @notes != 0
            for note in @notes
              note.update_attributes(:prevcustomer_id => nil,
                                     :unit_id => @unit.id)
            end
          end  
        @prev_customer.destroy                          
        flash[:notice] = "Customer Added!"
        redirect_to :action => "view_unit", :unit_num => @unit.unit_num, :building_id => @unit.building_id
      end
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