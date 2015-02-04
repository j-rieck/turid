require 'cinch'
require 'bitly'
require 'open-uri'

module Cinch
	module Plugins
		class Urlmagic
			include Cinch::Plugin

			set plugin_name: "Urlmagic"

			match /(https?:\/\/[^\s]+)/, use_prefix: false

			def execute(m, url)
				if url.match(/open\.spotify/)
					return
				end

				title = nil
				shortURL = nil

				open(url).find {|line| 
					title = line.match(/<title>(.*)<\/title>/)
				}

				unless title.nil?
					title = title[1].gsub(/[\r\n\t]/, '')
					title = title.strip
					title = title.gsub(/\s{2,}/, ' ')

					if url.length > 80
						Bitly.use_api_version_3
						bitly = Bitly.new('o_7ao1emfe9u', 'R_b29e38be56eb1f04b9d8d491a4f5b344')
						shortURL = bitly.shorten(url)
						shortURL = "(" + shortURL.short_url + ")"
					end

					m.reply %-"#{title}" #{shortURL}-
				end

			end
		end
	end
end