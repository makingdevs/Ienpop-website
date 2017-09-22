require './lib/ienpop/models/sede'
require 'json'
require 'net/http'
require 'ostruct'

class SedesManager 

	def initialize 
		uri = URI.parse("http://training.makingdevs.com.s3.amazonaws.com/data.json")
		content = Net::HTTP.get_response uri
		@values = JSON.parse(content.body, object_class: OpenStruct)

	end

	def list_all_sedes
		sedes = []
		@values.sedes.each do |c|
			sede = Sede.new
			sede.encargado = c.encargado
			sede.name = c.name
			sede.address = c.address
			sede.phone = c.phone
			sede.email = c.email
			sede.coordinates = c.coordinates
			sedes << sede
		end
		sedes
	end
end
