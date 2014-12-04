require 'cinch'
require 'cinch/plugins/spotify'
require 'cinch/plugins/downforeveryone'
require 'cinch/plugins/last_seen'

require './utils/settings'
require './utils/db'

Dir["./lib/cinch/plugins/*.rb"].each {|file| require file }

$conf = Settings.new("config.json")

bot = Cinch::Bot.new do
  configure do |c|
    c.nick              = $conf.nick
    c.realname          = $conf.name
    c.user              = $conf.user
    c.server            = $conf.server
    c.channels          = $conf.channels
    c.plugins.plugins   = [
        Cinch::Plugins::TheTime,
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
        Cinch::Plugins::Lastfm,
        Cinch::Plugins::Markov,
        Cinch::Plugins::BotAdm,
        Cinch::Plugins::Location,
        Cinch::Plugins::Alias
    ]
    c.plugins.prefix = /^\./
    c.shared = {:db => Db::new('fagbase')}
  end
end
bot.start
