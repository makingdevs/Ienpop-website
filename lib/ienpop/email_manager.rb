
class EmailManager

	def receive_info(params)
		puts "Estoy en la chase EmailManager"
		puts "#{params['name']}"
		puts "#{params['email']}"
		puts "#{params['subject']}"
		puts "#{params['message']}"
		puts "#{params['sedes']}"
		@name = params['name']
		@email = params['email']
		@subject = params['subject']
		@message = params['message']
		@sedes = params['sedes']

	end
end

