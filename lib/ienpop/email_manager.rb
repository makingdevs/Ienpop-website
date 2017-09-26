require 'mail'
require 'net/smtp'

class EmailManager 
  
  def initialize(address_mail, port_mail, authentication, user_name, password_mail, enable_starttls_auto)
    puts address_mail
    puts port_mail
    puts authentication
    puts user_name
    puts password_mail
    puts enable_starttls_auto
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

    begin     
      message = Mail.deliver({:to => "#{sede}",
            :from => ENV["USER_NAME"],
            :cc => "#{central_sede_email}",
            :subject => "#{subject}",
            :body => "#{message} \nMensaje enviado por #{name_contact}, con el siguiente correo de contacto #{email}"
            })
    rescue  
      puts 'Ocurrio un error al enviar el correo.'
      response = false  
    end  
      puts 'Correo enviado exitosamente.' 
      response = true
  end

end

