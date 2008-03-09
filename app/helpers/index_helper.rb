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
end
