class EmailNotifications < ActionMailer::Base
  def invalid_dig_email(message)
    # recipients 'reevooplus@reevoo.com'
    body :message => message
    subject "Possible invalid dig, ID: #{message.dig_id}"
    from "DONOTREPLY@theatredigsbooker.com"
    recipients ["admin@theatredigsbooker.com"]
  end
end
