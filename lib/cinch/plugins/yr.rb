# encoding=utf-8
require 'nokogiri'
require 'open-uri'
require 'htmlentities'
require 'uri'

module Cinch
	module Plugins
		class Yr
			include Cinch::Plugin
			@@places = Array.new

			set plugin_name: "Yr",
				help: "Bruk: .yr <sted>, eller lagre lokasjon med '.location set <lokasjon>'\nData hentet fra api.met.no er lisensiert under CC Navngivelse 3.0 Norge (CC BY 3.0) http://api.yr.no/lisens_data.html"

			match /yr\s?(.+)?/, method: :forecast
			match /w\s?(.+)?/, method: :forecast

			def forecast(m, loc)
				db = shared[:db]

				if loc.nil?
					loc = db.get(m.user.nick, plugin: "location")
					debug "lokasjon: #{loc}"
					if loc.nil?
						m.reply "Bruk: .yr <sted> [<kommune> og/eller <fylke>] eller lagre lokasjon med '.location set <lokasjon>'"
						return
					end
				end

				# Getting latitude and longitute
				latlon = db.get(loc)

				if latlon.nil?
					latlon = open(URI.encode("http://easygeo.uk/api.php?q=#{loc}")).string
					if latlon =~ /lat\/lon was not set/
						m.reply "Stedet #{loc} ble ikke funnet"
						return
					end

					db.put(loc, latlon)
				end

				# Getting name
				name = db.get(latlon)

				if name.nil?
					begin
						name_encoded = open(URI.encode("http://easygeo.uk/api.php?g=#{latlon}")).string.force_encoding("UTF-8")
						name = HTMLEntities.new.decode name_encoded
						db.put(latlon, name)
					rescue OpenURI::HTTPError
						debug "Name not found for coordinate #{latlon}"
					end
				end

				lat = latlon.scan(/\d+.\d+/)[0]
				lon = latlon.scan(/\d+.\d+/)[1]
				uri = "http://api.met.no/weatherapi/locationforecast/1.9/?lat=#{lat};lon=#{lon}"
				doc = Nokogiri::XML(open(URI.encode(uri)))
				data = doc.css("weatherdata product time:first")

				# All the different values we want to print
				temp = data.css("temperature").attr('value')
				windSpeed = data.css("windSpeed").attr('mps')
				windDirection = data.css("windDirection").attr('name')
				humidity = data.css("humidity").attr('value')

				reply = "Værdata for #{name}: #{temp}°C, #{windSpeed} m/s vind retning #{windDirection}, #{humidity}% luftfuktighet."
				
				uri = "http://api.met.no/weatherapi/textlocation/1.0/?language=nb;latitude=#{lat};longitude=#{lon}"
				doc = Nokogiri::XML(open(URI.encode(uri)))
				data = doc.css("weather time:first location:first")
				
				reply = reply + " " + data.css("forecast").content
				
				m.reply reply
			end
		end
	end
end
