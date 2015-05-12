require 'cinch'
require 'cinch/plugins/spotify'
require 'cinch/plugins/downforeveryone'
require 'cinch/plugins/last_seen'

require './utils/settings'
require './utils/db'

Dir['./lib/cinch/plugins/*.rb'].each {|file| require file }

$conf = Settings.new('config.json')

bot = Cinch::Bot.new do
  configure do |c|
    c.nick              = $conf.nick
    c.realname          = $conf.name
    c.user              = $conf.user
    c.server            = $conf.server
    c.channels          = $conf.channels

    $conf.plugins.each do |p|
        p = 'Cinch::Plugins::' + p
        plugin = p.split('::').inject(Object) {|o,c| o.const_get c}
        c.plugins.plugins.push plugin
    end

    c.plugins.prefix = /^\./
    c.shared = {:db => Db::new('turid')}
  end
end
bot.start