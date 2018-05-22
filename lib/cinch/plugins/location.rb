# encoding: utf-8
require 'cinch'

module Cinch
	module Plugins
		class Location
			include Cinch::Plugin

			set plugin_name: "Location",
				help: %-Set location with ".location set <location>", get location with ".location [<username>]" where the username is optional.-

			match /location(?!\s*set)(.+)?/, method: :get
			
			def get(m, nick)
				nick ||= m.user.nick
				db = shared[:db]
				if location = db.get(nick.strip!)
				  m.reply "#{nick}'s location is #{location}"
				else
				  m.reply "Did not find a location for #{nick}. Use '.location set <username>' to save a"
				end
			end

			match /location set (.+)/, method: :set
			def set(m, location)
				debug location
				debug location.encoding.to_s
				db = shared[:db]
				db.put(m.user.nick, location)
				m.reply "Updated #{m.user.nick}'s location"
			end
		end
	end
end