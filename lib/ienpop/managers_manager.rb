require './lib/ienpop/models/manager'
require 'json'
require 'net/http'

class ManagersManager

  def initialize
    uri = URI.parse("http://training.makingdevs.com.s3.amazonaws.com/manager.json")
    @content = Net::HTTP.get_response uri
  end


end

