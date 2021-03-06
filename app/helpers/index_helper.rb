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
  
  def if_selected(id)
    if id == @building.id
      "selected=\"selected\""
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
    
  def building_pop_up(height, width, rowspan, colspan, unit_num)
    render :partial => 'pop_up', :locals => {:height => height, :width => width, :rowspan => rowspan, :colspan => colspan, :unit_num => unit_num}
  end
  
end
