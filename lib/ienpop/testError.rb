require './lib/ienpop/models/sede'
require 'json'
require 'net/http'
require 'ostruct'

class Error

  def initialize
		uri = URI.parse("http://training.makingdevs.com.s3.amazonaws.com/data.json")
		content = Net::HTTP.get_response uri
		@values = JSON.parse(content.body, object_class: OpenStruct)
  end

  def testErro
    list = [1,2,3]
    cont = 0/1;
  end

end
