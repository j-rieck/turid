require 'cinch'

module Cinch
	module Plugins
		class Userinfo
			include Cinch::Plugin

			match /set ?(\w+) (.+)/, method: :set
			match /get ?(\w+)\.(\w+)/, method: :get

			def set(m, key, val)
				db = shared[:db]
				k = m.user.nick + "." + key
				db.put(k, val)
				m.reply %-Updated your #{key} to "#{val}"-
			end

			def get(m, user, key)
				db = shared[:db]
				k = user + "." + key
				if val = db.get(k)
					m.reply "#{user}'s #{key}: #{val}"
				else
					m.reply "No #{key} found for #{user}"
				end
			end

		end
	end
end