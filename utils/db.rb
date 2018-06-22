require 'sqlite3'

class Db
	@db = nil

	def initialize(name)
		database = Dir.pwd + '/db/' + name + '.sqlite'
		@db = SQLite3::Database.new(database)
	end

	def put(key, value, *values, plugin: caller[0][/\/(\w+)\.rb/, 1])
		@db.query "CREATE TABLE IF NOT EXISTS #{plugin}(id INTEGER PRIMARY KEY, key TEXT, value TEXT)"
		@db.query "INSERT OR REPLACE INTO #{plugin}(key, value) values (?, ?)", key, value
	end

	def update(key, value, *values, plugin: caller[0][/\/(\w+)\.rb/, 1])
		@db.query "UPDATE #{plugin} SET key = ?, value = ?", key, value
	end

	def get(key, *values, plugin: caller[0][/\/(\w+)\.rb/, 1])
		@db.query "CREATE TABLE IF NOT EXISTS #{plugin}(id INTEGER PRIMARY KEY, key TEXT, value TEXT)"
		value = @db.get_first_value "SELECT value from #{plugin} where key = ? ORDER BY id DESC", key
		return value
	end
end