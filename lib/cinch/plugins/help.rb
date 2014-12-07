require 'cinch'

module Cinch
	module Plugins
		class Help
			include Cinch::Plugin

			set plugin_name: "Help",
				help: "The very help you are reading now. use .help <command name> to get help on a specific command."

			match /help\s?(.+)?/i, method: :help
			match /list commands/, method: :list

			def help(m, plugin)
				if plugin.nil?
					m.user.privmsg %-To use me, type .<commandname>, to see all my commands, type ".list commands", to get on help a specific command, type .help <command name>-
				else
					list = {}
			        @bot.plugins.each { |p|
			        	list[p.class.plugin_name.downcase] = {plugin: p.class.plugin_name, help: p.class.help}
			        };
			        return m.user.privmsg("Help for \"#{plugin}\" could not be found.") if !list.has_key?(plugin.downcase)
			        m.user.privmsg("Help for #{Format(:bold,list[plugin.downcase][:plugin])}:\n#{list[plugin.downcase][:help]}")
				end
			end

			def list(m)

			end
		end
	end
end