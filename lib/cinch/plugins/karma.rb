require 'cinch'

module Cinch
	module Plugins
		class Karma
			include Cinch::Plugin

			set plugin_name: "Karma",
				help: %-<nick>++ || <nick>\-\- to increase karma, .karma <nick> to show karma"-

			match /(\S+)([+-]{2})/, method: :change_karma, use_prefix: false
			match /karma( \S+)?/, method: :get_karma

			def change_karma(m, nick, updown)
				if nick == m.user.nick
					m.reply "Dude, no changing your own karma"
					return
				end

				db = shared[:db]
				new_karma = 0;
				new_value = false

				if karma = db.get(nick)
					new_karma = karma.to_i
					new_value = true
				end

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

				m.user.privmsg "☆☆ #{nick}'s karma is #{new_karma} ☆☆"
			end

			def get_karma(m, nick)
				db = shared[:db]

				if nick.nil?
					nick = m.user.nick
				end

				if karma = db.get(nick.strip!)
					m.reply "#{nick}'s karma is #{karma}"
				else
					m.reply "#{nick} doesn't have any karma :("
				end
			end
		end
	end
end