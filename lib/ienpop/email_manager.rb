
class EmailManager

	def receive_info(params)
		@name = params['name']
		@email = params['email']
		@subject = params['subject']
		@message = params['message']
		@sedes = params['sedes']
	end

end

