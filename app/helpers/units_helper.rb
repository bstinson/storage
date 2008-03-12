module UnitsHelper
  def find_units_for_building(building_id)
   @units = Unit.find_all_by_building_id(building_id, :order => "unit_num ASC")
  end
end
