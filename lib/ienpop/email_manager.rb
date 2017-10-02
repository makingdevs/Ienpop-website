require 'mail'
require 'net/smtp'

class EmailManager 
  
  def initialize(address_mail, port_mail, authentication, user_name, password_mail, enable_starttls_auto)
    mail = Mail.defaults do
      delivery_method :smtp, { 
        :address        => address_mail,
        :port           => port_mail,
        :authentication => authentication,
        :user_name      => user_name,
        :password       => password_mail,
        :enable_starttls_auto => enable_starttls_auto 
      }
    end
    @user_name = user_name
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
            :from => @user_name,
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

