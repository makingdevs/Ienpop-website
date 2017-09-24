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

  def send_email(params, sedes)
    name_contact = params['name']
    email = params['email']
    subject = params['subject']
    message = params['message']
    sede = params['sedes']
    
    central_sede_email =  sedes[0].email
    puts central_sede_email

    message = Mail.deliver({:to => 'vanessa@makingdevs.com',
          :from => ENV["USER_NAME"],
          :cc => 'vanvanemily@gmail.com',
          :subject => "#{subject}",
          :body => "#{message} \nMensaje enviado por #{name_contact}, con el correo de #{email}"
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

