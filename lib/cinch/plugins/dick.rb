require 'cinch'
require 'dicks'

module Cinch
	module Plugins
		class Dick
		  include Cinch::Plugin

		  set plugin_name: "Dick",
		  		help: %-Get a given number of dicks. This plugin may serve up to 5 dicks at at once. Say: "Give me n penises" where n is the number of dicks you require-

		  match /give me (\d+) penises/i, use_prefix: false
			def execute(m, n)
				reply = ""
				if n.to_i > 5
					reply = "Don't be greedy. Max 5 penises."
				else
					dicks = Dicks::API.get_dicks(n)
					reply = dicks.join(" ")
				end

				m.reply(reply)
			end
		end
	end
end