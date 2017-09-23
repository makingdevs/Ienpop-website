require 'mail'
require 'net/smtp'

class EmailManager 
  
  options = { 
    :address        => ENV["ADDRESS_MAIl"],
    :port           => ENV["PORT_MAIL"],
    :authentication => ENV["AUTHENTICATION"],
    :user_name      => ENV["USER_NAME"],
    :password       => ENV["PASSWORD_MAIL"],
    :enable_starttls_auto => ENV["ENABLE_STARTTLS_AUTO"] 
  }

  Mail.defaults do
    delivery_method :smtp, options
  end

  Mail.deliver do
      to 'vanessa@makingdevs.com'
      from ENV["USER_NAME"]
      subject 'Sending EMAIl'
      body 'Pruebita 3'
  end

  def receive_info(params)
		@name = params['name']
		@email = params['email']
		@subject = params['subject']
		@message = params['message']
		@sedes = params['sedes']
	end


end

