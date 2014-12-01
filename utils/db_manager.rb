require "sqlite3"

class DBManager
  @db = nil

  def initialize(db_file)
    @db = SQLite3::Database.new db_file

    @db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS Users (nick VARCHAR(30) PRIMARY KEY, pass VARCHAR(255), priv INT(2))
    SQL

  end


end