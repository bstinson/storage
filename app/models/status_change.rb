class StatusChange < ActionMailer::Base
  def added(unit, user, email)
    @subject    = 'New Customer'
    @body       = {}
    @body["unit"] = unit
    @body["user"] = user
    @recipients = email
    @from       = 'storage@usdol.net'
    @sent_on    = Time.now
  end
  
  def cleared(unit, user, email)
    @subject    = 'Customer Removed'
    @body       = {}
    @body["unit"] = unit
    @body["user"] = user
    @recipients = email
    @from       = 'storage@usdol.net'
    @sent_on    = Time.now
  end
  
  def status(unit, user, email)
    @subject    = 'Status Change'
    @body       = {}
    @body["unit"] = unit
    @body["user"] = user    
    @recipients =  email
    @from       = 'storage@usdol.net'
    @sent_on    = Time.now
  end  
end
