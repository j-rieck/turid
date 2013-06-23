require 'cinch'
require 'nokogiri'
require 'bitly'
require 'open-uri'
require 'mechanize'

module Cinch
	module Plugins
		class Gee
			include Cinch::Plugin

			match /g (.+)/

			def execute(m, q)
				q = URI::encode(q)
				n = Nokogiri::HTML(open('http://google.com/search?q='+q+'&client=safari', 'User-Agent' => 'safari'))
				uri = "http://google.com" + n.css('h3.r a')[0]['href']+'&client=safari'

				mz = Mechanize.new
				mz.user_agent_alias = 'Mac Safari'
				p = mz.get(uri)
				title = p.title.gsub(/[\r\n\t]/, '')
				bitly = Bitly.new("o_7ao1emfe9u", "R_b29e38be56eb1f04b9d8d491a4f5b344")
				short = bitly.shorten(p.uri.to_s)

				m.reply "\"#{title}\" " + short.short_url
			end
		end
	end
end