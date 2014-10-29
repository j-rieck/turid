require 'cinch'

module Cinch
	module Plugins
		class Harmannenfaltned
		  include Cinch::Plugin

		  match /^har mannen falt ned\??/i, use_prefix: false

		  def execute(m)
		  	url = "http://www.vondess.com/mannen/api"
		  	data = JSON.parse(open(url).read)

		  	if data["falt_ned"] == false
		  		m.reply "Nei, Mannen har ikke falt ned enda"
		  	else
		  		m.reply "Jepp! Sjekk VG!"
		  	end
		  end
		end
	end
end