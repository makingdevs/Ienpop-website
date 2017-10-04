require 'mail'
require 'net/smtp'

class EmailManager 
  
  def initialize(server_mail, port_mail, authentication, user_name, password_mail, enable_starttls_auto, address_mail)
    mail = Mail.defaults do
      delivery_method :smtp, { 
        :address        => server_mail,
        :port           => port_mail,
        :authentication => authentication,
        :user_name      => user_name,
        :password       => password_mail,
        :enable_starttls_auto => enable_starttls_auto 
      }
    end
    @address_mail = address_mail
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
            :from => @address_mail,
            :cc => "#{central_sede_email}",
            :subject => "#{subject}",
            :body => "#{message} \nMensaje enviado por #{name_contact}, con el siguiente correo de contacto #{email}"
            })
      @response = true
    rescue Exception => e
      puts e.message 
      @response = false  
    end  
      @response
  end

end

