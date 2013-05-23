require 'cinch'
require 'cinch/plugins/spotify'
require 'cinch/plugins/downforeveryone'
require 'cinch/plugins/last_seen'
require 'cinch/plugins/gee'
require 'cinch/plugins/urlmagic'
require 'cinch/plugins/hello'
require 'cinch/plugins/plugin_management'

class TheTime
	include Cinch::Plugin

	match /thetime/

	def execute(m)
		m.reply "#{m.user.nick}: Looks like it's fuck-this-shit o'clock"
	end
end

bot = Cinch::Bot.new do
  configure do |c|
  	c.nick = "faggot"
  	c.realname = "rainbowz"
  	c.server = "efnet.xs4all.nl"
  	c.channels = ["#fag4lyfe", "#mac1"]
  	c.plugins.plugins = [Cinch::Plugins::Spotify, Cinch::Plugins::DownForEveryone, Cinch::Plugins::LastSeen, Cinch::Plugins::Hello, TheTime, Cinch::Plugins::URLMagic, Cinch::Plugins::Gee, Cinch::Plugins::PluginManagement]
  	c.plugins.prefix = /^\./
  end
end

bot.start