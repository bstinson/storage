class StatusChange < ActionMailer::Base
  def added(unit, user)
    @subject    = 'New Customer'
    @body       = {}
    @body["unit"] = unit
    @body["user"] = user
    @recipients = 'gary@usdol.net, kim@usdol.net, ssdoors@usdol.net, asmith@usdol.net'
    @from       = 'storage@usdol.net'
    @sent_on    = Time.now
  end
  
  def cleared(unit, user)
    @subject    = 'Customer Removed'
    @body       = {}
    @body["unit"] = unit
    @body["user"] = user
    @recipients = 'brads@usdol.ne'
    @from       = 'storage@usdol.net'
    @sent_on    = Time.now
  end
  
  def status(unit, user)
    @subject    = 'Status Change'
    @body       = {}
    @body["unit"] = unit
    @body["user"] = user    
    @recipients =  'gary@usdol.net, kim@usdol.net, ssdoors@usdol.net, asmith@usdol.net'
    @from       = 'storage@usdol.net'
    @sent_on    = Time.now
  end  
end
