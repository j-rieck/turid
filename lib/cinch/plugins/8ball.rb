require 'cinch'

module Cinch
	module Plugins
		class EightBall
		  include Cinch::Plugin

		  set plugin_name: "8ball"

		  match /^!8ball |\?$/i, use_prefix: false

			answers = [
					"No!",
					"Yes!",
					"Of course.",
					"All fingers point to yes.",
					"All fingers point to no.",
					"It's likely.",
					"Ask again later.",
					"You may rely on it.",
					"Cannot predict now.",
					"Don't count on it.",
					"Outlook not so good.",
					"Without a doubt."
			]

		  def execute(m)
		  	sleep(1)
		  	m.reply "#{m.user.nick}: #{answers.sample}"
		  end
		end
	end
end