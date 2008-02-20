module UsersHelper
  def show_company_name_for_id(id)
    @company = Company.find_by_id(id)
    @company.name
  end
end
