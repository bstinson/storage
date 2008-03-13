module IndexHelper
  def if_empty(label, value)
    if value == ""
    else
  	  "<tr>
  			<td class=\"label\">" + label + ":</td>
  			<td>" + value + "</td>
  		</tr>"
    end
  end
  
  # Formats address onto two lines
  def format_address(address, city, state, zip)
    address + "<br />" + city + ", " + state + " " + zip.to_s
  end
  
  # Picks color for unit status
  def unit_color(unit_num)
    @unit = Unit.find_by_unit_num_and_building_id(unit_num, @building.id)
    @unit.status
  end
  
  #Show unit dimensions
  def unit_dimensions(width, height)
    render :inline => width.to_s + ' x ' + height.to_s
  end
    
  # Renders td with scripts for West Side buildings and their popups
  def building_pop_up(height, width, status, unit_num)
    render :partial => 'west_side', :locals => {:height => height, :width => width, :status => status, :unit_num => unit_num}
  end 
  
  def west_side1(unit_num, rowspan)
    render :text => '<td rowspan="' + (rowspan.to_s) + '" class="<%= unit_color('+ (unit_num.to_s) + ')%>"><%= link_to "'+ (unit_num.to_s) +'", :action => "view_unit", :unit_num => "' + (unit_num.to_s) + '", :building_id => @building %></td>'
  end   
end
