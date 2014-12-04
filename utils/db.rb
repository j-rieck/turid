require 'sqlite3'

class Db
	@db = nil

	def initialize(name)
		database = Dir.pwd + '/db/' + name + '.sqlite'
		@db = SQLite3::Database.new(database)
	end

	def test(*values, table: caller[0][/\/(\w+)\.rb/, 1])
		return 'test ' + table
	end

	def put(key, value, *values, table: caller[0][/\/(\w+)\.rb/, 1])
		@db.execute "CREATE TABLE IF NOT EXISTS #{table}(
						id INTEGER PRIMARY KEY,
						key TEXT,
						value TEXT)"

		@db.execute "INSERT OR REPLACE INTO #{table}(key, value) values ('#{key}', '#{value}')"
	end

	def get(key, *values, table: caller[0][/\/(\w+)\.rb/, 1])
		if table.nil?
			table = caller[0][/`([^']*)'/, 1]
		end

		@db.execute "CREATE TABLE IF NOT EXISTS #{table}(
						id INTEGER PRIMARY KEY,
						key TEXT,
						value TEXT)"

		value = @db.get_first_value "SELECT value from #{table} where key = '#{key}'"
		return value
	end
end