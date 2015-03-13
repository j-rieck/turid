require 'cinch'
require 'open-uri'

module Cinch
	module Plugins
		class Strava
			include Cinch::Plugin

			set plugin_name: "Strava",
				help: "To set your Strava user, use .strava set <user_id>. You can find your user ID in the URL of your user profile https://www.strava.com/athletes/<user_id>",
				help: "Fetch last activity with the strava command or add a nick as an option to see other users recent activity"

			@@settings_file = Dir.pwd + '/lib/data/strava.settings.rb'

			match /strava ?(\w+)? ?(\w+)?/, method: :strava

			def initialize(*args)
				super

				bot.configure do |c|
					c.plugins.options[Cinch::Plugins::Strava] = eval( File.open(@@settings_file, "rb").read )
				end
			end

			def strava(m, command, option)
				case command
				when nil
					get_user_activity(m, nil)
				when "set"
					set_user_id(m, option.strip)
				else
					get_user_activity(m, option.strip)
				end
			end

			def get_user_activity(m, nick)
				nick ||= m.user.nick
				db = shared[:db]
				userid = db.get(nick.strip)

				if userid.nil?
					m.reply "No Strava ID saved for #{nick}"
					return
				end
				url = "https://www.strava.com/api/v3/athletes/#{userid}/activities"
				data = JSON.parse(
							open(
								url,
								"Authorization" => "access_token " + config[:access_token]
							)
						.read)[0]

				case data['type']
				when "Ride"
					verb = "rode"
				when "Run"
					verb "ran"
				end

				reply = "#{nick} #{verb} #{data['distance'] / 1000} km and climbed #{data['total_elevation_gain']} meters averaging #{data['weighted_average_watts']}W (weighted) near #{data['location_city']}, #{data['location_country']}."
				reply += "\nhttp://www.strava.com/activities/#{data['id']}"
				m.reply reply
			end

			def set_user_id(m, userid)
				db = shared[:db]
				db.put(m.user.nick, userid)
				m.reply "Updated user #{m.user.nick} with Strava ID #{userid}"
			end
		end
	end
end