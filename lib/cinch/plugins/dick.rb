require 'cinch'
require 'dicks'

module Cinch
	module Plugins
		class Dick
		  include Cinch::Plugin

		  match /gi meg (\d+) penis/i, use_prefix: false
			def execute(m, n)
				reply = ""
				if n.to_i > 5
					reply "Nå må du ikke være grådig. Maks 5 peniser."
				else
					dicks = Dicks::API.get_dicks(n)
					reply = dicks.join(" ")
				end

				m.reply(reply)
			end
		end
	end
end