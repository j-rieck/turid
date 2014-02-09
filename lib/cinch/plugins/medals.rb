# encoding: utf-8

require 'cinch'
require 'open-uri'

module Cinch
	module Plugins
		class Medals
      include Cinch::Plugin

      match /ol\s?(.+)?/
      def execute(m, c)
        url = "http://olympics.clearlytech.com/api/v1/medals"
        data = JSON.parse(open(url).read)

        if c.nil?
          c = "Norway"
        end

        country = data.select {|d| d["country_name"] == c}[0]
        gold = country["gold_count"]
        silver = country["silver_count"]
        bronze = country["bronze_count"]

        m.reply "Medaljer i Sotsji (#{c}): #{gold} gull, #{silver} sølv og #{bronze} bronse"
      end
    end
  end
end