require 'cinch'

module Cinch
	module Plugins
		class Hello
		  include Cinch::Plugin

		  set plugin_name: "Hello"

		  match /^H[ae](i|llo|y)(en|sann)?$/i, use_prefix: false

		  def execute(m)
		  	sleep(1)
		  	m.reply "Hello #{m.user.nick}!"
		  end
		end
	end
end