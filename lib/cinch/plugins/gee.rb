require 'cinch'
require 'nokogiri'
require 'bitly'
require 'open-uri'
require 'mechanize'
require 'cgi'
# require 'iconv'

module Cinch
  module Plugins
    class Gee
      include Cinch::Plugin

      match /g (.+)/

      def get_url_info (q)
        url       = "http://google.com/search?q=#{CGI.escape(q)}&sourceid=chrome&ie=UTF-8"
        res       = Nokogiri::HTML(open(url)).at("h3.r a")

        return res;
      end

      def execute(m, q)
        response  = get_url_info q

        title = ""
        response.children.each do |c|
          title = title + c.text
        end

        url      = /q=([^&]+)/.match(response.attributes['href'].value)[1]
        domain   = /(https?:\/\/)?(www.)?([^\/]+)/.match(url)[3]
        bitly     = Bitly.new("o_7ao1emfe9u", "R_b29e38be56eb1f04b9d8d491a4f5b344")

        begin
          short   = bitly.shorten(url).short_url
        rescue
          begin
            short = bitly.shorten(url).short_url
          rescue
            short = url
          end
        end

        m.reply %?"#{title}" - #{short} (#{domain})?
      end
    end
  end
end