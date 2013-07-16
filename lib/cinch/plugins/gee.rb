require 'cinch'
require 'nokogiri'
require 'bitly'
require 'open-uri'
require 'mechanize'
require 'cgi'
require 'iconv'

module Cinch
	module Plugins
		class Gee
			include Cinch::Plugin

			match /g (.+)/

      def get_url_info (q)
        url       = "http://google.com/search?q=#{CGI.escape(q)}&sourceid=chrome&ie=UTF-8"
        res       = Nokogiri::HTML(open(url)).at("h3.r")

        return res;
      end

			def execute(m, q)
        ic        = Iconv.new('UTF-8//IGNORE', 'UTF-8')

        response  = get_url_info q

        title     = ic.iconv(response.text)
        link      = response.at('a')[:href][7..-1]
        url       = link.scan(/(https?:\/\/)?(www.)?(.+)\//).last

        debug title
        debug link

        url = url.nil? ? "" : url.last

				bitly     = Bitly.new("o_7ao1emfe9u", "R_b29e38be56eb1f04b9d8d491a4f5b344")

        begin
          short   = bitly.shorten(link).short_url
        rescue
          begin
            short = bitly.shorten("http://"+link).short_url
          rescue
            short = url
          end
        end

				m.reply %-«#{title}» \- #{short} (#{url})-
			end
		end
	end
end