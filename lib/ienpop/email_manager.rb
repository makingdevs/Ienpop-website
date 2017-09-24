require 'mail'
require 'net/smtp'

class EmailManager 
  

  def settings
    mail = Mail.defaults do
      delivery_method :smtp, { 
        :address        => ENV["ADDRESS_MAIL"],
        :port           => ENV["PORT_MAIL"],
        :authentication => ENV["AUTHENTICATION"],
        :user_name      => ENV["USER_NAME"],
        :password       => ENV["PASSWORD_MAIL"],
        :enable_starttls_auto => ENV["ENABLE_STARTTLS_AUTO"] 
      }
    end
  end

  def send_email
    message = Mail.deliver({:to => 'vanessa@makingdevs.com',
          :from => ENV["USER_NAME"],
          :subject => 'Pruebas',
          :body => 'Sending email for testing'
          })
  end



  def receive_info(params)
		@name = params['name']
		@email = params['email']
		@subject = params['subject']
		@message = params['message']
		@sedes = params['sedes']
	end


end

