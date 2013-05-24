require 'cinch'
require 'mechanize'
require 'bitly'

module Cinch
	module Plugins
		class URLMagic
			include Cinch::Plugin

			match /(https?:\/\/[^\s]+)/, use_prefix: false

			def execute(m, url)
				if url.match(/open\.spotify/)
					return
				end

				agent = Mechanize.new
				page = agent.get(url)
				title = page.title.gsub(/[\r\n\t]/, '')
				shortURL = ""

				if url.length > 80
					Bitly.use_api_version_3
					bitly = Bitly.new('o_7ao1emfe9u', 'R_b29e38be56eb1f04b9d8d491a4f5b344')
					shortURL = "(" + bitly.shorten(url) + ")"
				end
				
				m.reply %-"#{title}" #{shortURL.short_url}-
			end
		end
	end
end