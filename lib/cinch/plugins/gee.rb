require 'cinch'
require 'nokogiri'
require 'bitly'
# require 'open-uri'
# require 'mechanize'
require 'google-search'

module Cinch
	module Plugins
		class Gee
			include Cinch::Plugin

			match /g (.+)/

			def execute(m, q)
				search = Google::Search::Web.new
				search.query = q

				# q = m.message.gsub(/^!g /, '')
				q = URI::encode(q)
				n = Nokogiri::HTML(open('http://google.com/search?q='+q,
																'User-Agent' => 'Chrome/26.0.1410.65 Safari/537.31'))
				uri = "http://google.com" + n.css('h3.r a')[0]['href']+'&client=queef'

				mz = Mechanize.new
				mz.user_agent_alias = 'Mac Safari'
				p = mz.get(uri)
				title = p.title.gsub(/[\r\n\t]/, '')
				debug title
				bitly = Bitly.new("o_7ao1emfe9u", "R_b29e38be56eb1f04b9d8d491a4f5b344")
				short = bitly.shorten(p.uri.to_s)

				m.reply "\"#{title}\" " + short.short_url
			end
		end
	end
end