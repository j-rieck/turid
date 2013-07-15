require 'cinch'
require 'nokogiri'
require 'bitly'
require 'open-uri'
require 'mechanize'
require 'cgi'

module Cinch
	module Plugins
		class Gee
			include Cinch::Plugin

			match /g (.+)/

      def get_url_info (q)
        url = "http://google.com/search?q=#{CGI.escape(q)}&sourceid=chrome&ie=UTF-8"
        res = Nokogiri::HTML(open(url)).at("h3.r")

        return res;
      end

			def execute(m, q)
        response  = get_url_info q

        title     = response.text
        link      = response.at('a')[:href][7..-1]
        url       = link.scan(/\/\/(.+)\//).first

				bitly     = Bitly.new("o_7ao1emfe9u", "R_b29e38be56eb1f04b9d8d491a4f5b344")
        short     = bitly.shorten(link)

				m.reply %-«#{title}» \- #{short.short_url} (#{url.first})-
			end
		end
	end
end