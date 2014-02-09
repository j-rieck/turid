require 'cinch'
require 'open-uri'

module Cinch
	module Plugins
		class Medals
      include Cinch::Plugin

      match /ol/
      def execute(m)
        url = "http://olympics.clearlytech.com/api/v1/medals"
        data = JSON.parse(open(url).read)
        norway = data.select {|d| d["country_name"] == "Norway"}[0]
        gold = norway["gold_count"]
        silver = norway["silver_count"]
        bronze = norway["bronze_count"]

        m.reply "Medaljer i Sotsji: #{gold} gull, #{silver} sølv og #{bronze} bronse"
      end
    end
  end
end