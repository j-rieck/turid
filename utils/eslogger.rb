require 'bundler/setup'
require 'elasticsearch'

class ESLogger
  def initialize
    @client = Elasticsearch::Client.new log: true
    @client.cluster.health

    @index = "chanlog"
    @type = "item"
  end

  def save_message(time, name, msg)
    @client.index index: @index, type: @type, body: { time: time, name: name, message: msg }
    @client.indices.refresh index: @index
  end

  def search(q)
    @client.search index: @index, body: { query: { multi_match: { query: q, fields: ["name","message"] } } }
  end
end