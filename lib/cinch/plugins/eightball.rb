require 'cinch'

module Cinch
	module Plugins
		class Eightball
		  include Cinch::Plugin

		  set plugin_name: "Eightball"

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
			
		  match /^8ball/i, use_prefix: false
		  def execute(m)
		  	sleep(1)
		  	m.reply "#{m.user.nick}: #{answers.sample}"
		  end
		end
	end
end
