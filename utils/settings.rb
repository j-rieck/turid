require "json"

class Settings

  def initialize(file)
    @json = nil
    begin
      File.open(file, "r") do |f|
        @json = JSON.load(f)
      end
    rescue
      abort "\nconfig.json is missing"
    end


    objectify
  end

  def objectify
    @json.each do |k,v|
      self.instance_variable_set("@#{k}", v)  ## create and initialize an instance variable for this key/value pair
      self.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})  ## create the getter that returns the instance variable
      self.class.send(:define_method, "#{k}=", proc{|v| self.instance_variable_set("@#{k}", v)})  ## create the setter that sets the instance variable
    end
  end
end