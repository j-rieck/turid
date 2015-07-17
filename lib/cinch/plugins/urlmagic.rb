require 'cinch'
require 'bitly'
require 'open-uri'

module Cinch
	module Plugins
		class Urlmagic
			include Cinch::Plugin

			set plugin_name: "Urlmagic",
				help: "Automatically fetches titles for URLs and shortens them if they are long"

			match /(https?:\/\/[^\s]+)/, use_prefix: false

			def execute(m, url)
				agent = Mechanize.new
				page = agent.get(url)
				begin
					title = page.title.gsub(/[\r\n\t]/, '')
					title = title.strip
					title = title.gsub(/\s{2,}/, ' ')
					downcasetitle = title.downcase.gsub(/[^a-z0-9\s]/i, ' ')
					titlewords = downcasetitle.split(" ")
					downcaseurl = url.downcase.gsub(/[^a-z0-9\s]/i,' ')
					urlwords = downcaseurl.split(" ")
        				count = 0
          				titlewords.each {|word| count += 1 if urlwords.include?(word)}
				rescue
					title nil
					debug "could not get title"
				end
				shortURL = ""

				if url.length > 80
					Bitly.use_api_version_3
					bitly = Bitly.new('o_7ao1emfe9u', 'R_b29e38be56eb1f04b9d8d491a4f5b344')
					shortURL = bitly.shorten(url)
					shortURL = "(" + shortURL.short_url + ")"
				end

				page = nil
				agent = nil
				GC.start

				unless title.nil?
				  m.reply %-"#{title}" #{shortURL}- if count > (urlwords.count/2)
				end
			end
		end
	end
end
