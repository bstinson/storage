module IndexHelper
  #Daily Statistics Helpers
  
  def find_all_units_for_company_id()
    @units = Units.find_by_id(@company_id)
  end
end
