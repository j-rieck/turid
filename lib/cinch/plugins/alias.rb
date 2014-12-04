require 'cinch'

module Cinch
	module Plugins
		class Alias
			include Cinch::Plugin

			match /alias (\S+) (.+)/, method: :create_alias
			def create_alias(m, a, message)
				db = shared[:db]
				db.put(a, message)
				m.reply "Lagret aliaset @#{a}"
			end

			match /^@(\S+)/, method: :get_alias, use_prefix: false
			def get_alias(m, a)
				db = shared[:db]
				message = db.get(a)
				m.reply message
			end
		end
	end
end