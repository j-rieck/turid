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
				  m.reply "#{nick} sin lokasjon er #{location}"
				else
				  m.reply "Fant ingen lagret lokasjon på #{nick}. Bruk '.location set <username>' for å lagre lokasjon"
				end
			end

			match /location set (.+)/, method: :set
			def set(m, location)
				debug location
				debug location.encoding.to_s
				db = shared[:db]
				db.put(m.user.nick, location)
				m.reply "Oppdaterte lokasjonen til #{m.user.nick}"
			end
		end
	end
end