class StatusChange < ActionMailer::Base
  def added(unit)
    @subject    = 'New Customer'
    @body       = {}
    @body["unit"] = unit
    @recipients = 'brads@usdol.net'
    @from       = 'storage@usdol.net'
    @sent_on    = Time.now
  end
  
  def cleared(unit)
    @subject    = 'Customer Removed'
    @body       = {}
    @body["unit"] = unit
    @recipients = 'brads@usdol.net'
    @from       = 'storage@usdol.net'
    @sent_on    = Time.now
  end
  
  def status(unit)
    @subject    = 'Status Change'
    @body       = {}
    @body["unit"] = unit
    @recipients = 'brads@usdol.net'
    @from       = 'storage@usdol.net'
    @sent_on    = Time.now
  end  
end
