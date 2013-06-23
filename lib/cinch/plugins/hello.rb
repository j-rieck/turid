require 'cinch'

module Cinch
	module Plugins
		class Hello
		  include Cinch::Plugin

		  match /^[Hh][ae](i|llo)$/, use_prefix: false

		  def execute(m)
		  	sleep(1)
		  	m.reply "Hei #{m.user.nick}!"
		  end
		end
	end
end