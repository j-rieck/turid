require 'cinch'

module Cinch
	module Plugins
		class Karma
			include Cinch::Plugin

			set plugin_name: "Karma",
				help: %-<nick>++ || <nick>\-\- to increase karma, .karma <nick> to show karma"-

			match /(\S+)([+-]{2})/, method: :change_karma, use_prefix: false
			match /karma (\S+)/, method: :get_karma

			def change_karma(m, nick, updown)
				db = shared[:db]
				new_karma = 0;
				new_value = false

				if karma = db.get(nick)
					debug "==== old karma detected! ==="
					new_karma = karma.to_i
					debug "old karma: " + karma.to_s
					debug "========="
					new_value = true
				end

				debug "==============="
				debug "nick: " + nick
				debug "updown:" + updown + ".."
				debug "old karma: " + new_karma.to_s
				debug "new value?: " + new_value.to_s
				debug "==============="


				if updown.eql? "++"
					new_karma += 1
				else
					new_karma -= 1
				end

				debug "karma is =>" + new_karma.to_s

				if new_value
					db.update(nick, new_karma)
				else
					db.put(nick, new_karma)
				end

				m.reply "☆☆ #{nick}'s karma is #{new_karma} ☆☆"
			end

			def get_karma(m, nick)
				db = shared[:db]

				if karma = db.get(nick)
					m.reply "#{nick}'s karma is #{karma}"
				else
					m.reply "#{nick} doesn't have any karma :("
				end
			end
		end
	end
end