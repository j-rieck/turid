require 'bundler/setup'
require 'elasticsearch'

class ESLogger
  def new (*args)
    @client = Elasticsearch::Client.new log: true
    @index = ""
    @type = ""
  end

  def insert_data
    "afafafafsssaf"
  end
end