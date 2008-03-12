# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def show_company_name_for_id(id)
    @company = Company.find_by_id(id)
    @company.name
  end
  
  def if_current_company(id, name)
    if id == @company_id.id.to_i
  		  link_to truncate(name, 20, "..."), {:controller => 'index'}, :style => 'color:#FFF;background-color:#15A;text-decoration:none;'
  		else
  		  link_to truncate(name, 20, "..."), :controller => 'index', :company_id => id 
    end    
  end
  
  def format_date(date)
     h date.strftime("%b %d, %Y")
  end
  
  def show_name_for_id(id)
    @user_for_note = User.find_by_id(id)
    @user_for_note.name.capitalize
  end
end
