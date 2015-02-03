require 'cinch'
require 'mechanize'

module Cinch
	module Plugins
		class Xkcd
			include Cinch::Plugin

			set plugin_name: "Xkcd",
				help: "Show the latest xkcd comic or provide the id for a specific one: .xkcd [<id>]"

			match /xkcd\s?(\d+)?/

			def execute(m, id)
				strip = ""

				unless id.nil?
					strip = id
				end

				uri =  "http://xkcd.com/" + strip
		    agent = Mechanize.new
		    begin
		      page = agent.get(uri)
		    rescue Mechanize::ResponseCodeError
		      m.reply "Sorrymac. Stripa finnes ikke"
		      return
		    end
		    title = page.title.gsub(/[\r\n]/, '')
		    m.reply %-"#{title}" #{uri}-
			end
		end
	end
end