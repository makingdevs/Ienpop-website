require './lib/ienpop/models/manager'
require 'json'
require 'net/http'

class ManagersManager

  def initialize
    uri = URI.parse("http://training.makingdevs.com.s3.amazonaws.com/data.json")
    content = Net::HTTP.get_response uri
    @values = JSON.parse(content.body)
  end

  def list_all_manager
    managers = []
    @values["manager"].each do |child|
      manager = Manager.new
      manager.name = child["name"],
      manager.area = child["area"],
      manager.email = child["email"]
      managers <<  manager
    end
    managers
  end


end

