#!/bin/env ruby
# encoding: utf-8

require 'cinch'

module Cinch
	module Plugins
		class Ask
		  include Cinch::Plugin

		  match /ask\s?(.+)?/

		  def execute(m, nick)
		  	unless nick.nil?
		  		nick = %-Hør nå her #{nick}:-
		  	end
		  	m.reply %-#{nick}Du trenger ikke å be om å spørre, eller å be om en "ekspert" på noe. Bare skriv ditt spørsmål i kanalen. Hvis noen kan hjelpe, vil de gjøre det. Du kan ikke forvene å få et svar umiddelbart. Vær tålmodig. Vær villig til å vente en liten stund etter å ha spurt i tilfelle noen ser spørsmålet ditt senere og prøver å hjelpe. Hvis du forlater kanalen for raskt kan du få glipp av nyttige svar.-
		  end
		end
	end
end