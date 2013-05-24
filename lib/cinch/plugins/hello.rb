require 'cinch'

module Cinch
	module Plugins
		class Hello
		  include Cinch::Plugin

		  match /^H[ae](i|llo)(en|sann)?$/i, use_prefix: false

		  def execute(m)
		  	m.reply "Hei #{m.user.nick}!"
		  end
		end
	end
end