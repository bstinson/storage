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
end
