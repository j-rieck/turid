# encoding: utf-8

require 'cinch'
require 'open-uri'

module Cinch
	module Plugins
		class Medals
      include Cinch::Plugin

      match /ol\s?(.+)?/
      def execute(m, c)
        url = "http://mapi.sochi2014.com/v1/en/olympic/medal/rating"
        data = JSON.parse(open(url).read)

        if c.nil?
          c = "Norway"
        end
        # debug data.to_s 
        country = data.select {|d| d["name"].match(/#{c}/i)}[0]#debug d.to_s}# )[0]} #d["name"] == c
        m.reply "Medaljer i Sotsji (#{country["name"]}): #{country["gold"]} gull, #{country["silver"]} sølv og #{country["bronze"]} bronse"
      end
    end
  end
end