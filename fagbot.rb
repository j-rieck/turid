require 'cinch'
require 'cinch/plugins/spotify'
require 'cinch/plugins/downforeveryone'
require 'cinch/plugins/last_seen'
Dir["./lib/cinch/plugins/*.rb"].each {|file| require file }

class TheTime
	include Cinch::Plugin

	match /thetime/

	def execute(m)
		m.reply "#{m.user.nick}: Looks like it's fuck-this-shit o'clock"
	end
end

bot = Cinch::Bot.new do
  configure do |c|
  	c.nick = "faggotz"
  	c.realname = "rainbowz"
  	c.server = "efnet.xs4all.nl"
  	c.channels = ["#fag4lyfe"]#, "#mac1"]
  	c.plugins.plugins = [Cinch::Plugins::Spotify, Cinch::Plugins::DownForEveryone, Cinch::Plugins::LastSeen, Cinch::Plugins::Hello, TheTime, Cinch::Plugins::Urlmagic, Cinch::Plugins::Gee, Cinch::Plugins::PluginManagement, Cinch::Plugins::Xkcd, Cinch::Plugins::Ask, Cinch::Plugins::Yr]
  	c.plugins.prefix = /^\./
  end

  on :message, /^.reload plugins/ do |m|
  	Dir["./lib/cinch/plugins/*.rb"].each {|file| require file }
  end
end

bot.start