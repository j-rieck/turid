require 'cinch'

module Cinch
	module Plugins
		class Location
			include Cinch::Plugin

			set plugin_name: "Location",
				help: %-Set location with ".location set <location>", get location with ".location [<username>]" where the username is optional.-

			match /location(?!\s*set)(\w+)?/, method: :get
			def get(m, nick)
				nick ||= m.user.nick
				db = shared[:db]
				location = db.get(nick)
				location ||= "Fant ingen lagret lokasjon på #{nick}. Bruk '.location set <username>' for å lagre lokasjon"
				m.reply "#{nick} sin lokasjon er #{location}"
			end

			match /location set (\w+)/, method: :set
			def set(m, location)
				db = shared[:db]
				db.put(m.user.nick, location)
				m.reply "Oppdaterte lokasjonen til #{m.user.nick}"
			end
		end
	end
end