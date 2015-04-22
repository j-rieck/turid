require 'cinch'

module Cinch
	module Plugins
		class Userinfo
			include Cinch::Plugin

			set plugin_name: "Userinfo",
				help: %-Set any info with ".set <key> <info>", get the info of a user with ".get <username>.<key>" like ".set name turid"; ".get turid.name" yields "turid's name: turid".-


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