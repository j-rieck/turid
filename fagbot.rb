require 'cinch'
require 'cinch/plugins/spotify'
require 'cinch/plugins/downforeveryone'
require 'cinch/plugins/last_seen'

require './utils/settings'

Dir["./lib/cinch/plugins/*.rb"].each {|file| require file }

$conf = Settings.new("config.json")

class TheTime
  include Cinch::Plugin

  match /thetime/

  def execute(m)
    m.reply "#{m.user.nick}: Looks like it's fuck-this-shit o'clock"
  end
end

bot = Cinch::Bot.new do
  configure do |c|
    c.nick              = $conf.nick
    c.realname          = $conf.name
    c.user              = $conf.user
    c.server            = $conf.server
    c.channels          = $conf.channels
    c.plugins.plugins   = [
        TheTime,
        Cinch::Plugins::Spotify,
        Cinch::Plugins::DownForEveryone,
        Cinch::Plugins::LastSeen,
        Cinch::Plugins::Hello,
        Cinch::Plugins::Urlmagic,
        Cinch::Plugins::Gee,
        Cinch::Plugins::PluginManagement,
        Cinch::Plugins::Xkcd,
        Cinch::Plugins::Ask,
        Cinch::Plugins::Yr,
        Cinch::Plugins::BotAdm
    ]

    c.plugins.prefix    = /^\./
  end
end

bot.start