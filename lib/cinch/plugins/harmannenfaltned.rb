require 'cinch'

module Cinch
	module Plugins
		class Harmannenfaltned
		  include Cinch::Plugin

		  set plugin_name: "Harmannenfaltned",
		  		help: %-Neat feature to check if the famous Mannen mountain has fallen down. Simply ask the bot "har mannen falt ned?" and you shall know. Now also with a check if Dovre has fallen.-

		  match /har mannen falt ned/i, method: :mannen, use_prefix: false
		  match /har dovre falt/i, method: :dovre, use_prefix: false
		  match /har veslemannen falt ned/i method :veslemannen, use_prefix: false

		  def mannen(m)
		  	url = "https://www.vondess.com/mannen/api"
		  	data = JSON.parse(open(url).read)

		  	if data["falt_ned"] == false
		  		m.reply "Nei, Mannen har ikke falt ned enda"
		  	else
		  		m.reply "Jepp! Sjekk VG!"
		  	end
		  end

		  def dovre(m)
		  	url = "https://www.vondess.com/dovre/api"
		  	data = JSON.parse(open(url).read)

		  	if data["falt_ned"] == false
		  		m.reply "Nei, Dovre har ikke falt enda"
		  	else
		  		m.reply "Jepp! Ring VG!"
		  	end
		  end
			
		  def veslemannen(m)
			  url = "https://www.vondess.com/veslemannen/api"
			  data = JSON.parse(open(url).read)

		  	  if data["falt_ned"] == false
		  		m.reply "Nei, veslemannen har ikke falt enda"
		  	  else
		  		m.reply "Jepp! Ring VG!"
		  	  end
		end
	end
end
