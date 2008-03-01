# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def show_company_name_for_id(id)
    @company = Company.find_by_id(id)
    @company.name
  end
  
  def if_current_company(id, name)
    if id == @user.company_id.to_i
  		  link_to name, {:controller => 'index'}, :style => 'color:#FFF;background-color:#7B4;text-decoration:none;'
  		else
  		  link_to name, :controller => 'index'
    end    
  end
  
  def in_place_select_editor(field_id, options = {})

    function = "new Ajax.InPlaceSelectEditor("
    function << "'#{field_id}', "
    function << "'#{url_for(options[:url])}'"
    function << (', ' + options_for_javascript(
      {
        'selectOptionsHTML' =>
            %('#{escape_javascript(options[:select_options].gsub(/\n/, ""))}')
      }
      )
    ) if options[:select_options]
         function << ')'
    javascript_tag(function)

  end

end
