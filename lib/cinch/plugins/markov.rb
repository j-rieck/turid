require 'marky_markov'
require 'cinch'

module Cinch
	module Plugins
		class Markov
		  include Cinch::Plugin

		  set plugin_name: "Markov"

		  listen_to :channel, method: :execute
		  timer 60, method: :save_dict

		  def initialize(*args)
		  	super(*args)
		  	@markov = MarkyMarkov::Dictionary.new('markov_dictionary')
		  end

		  def execute(m)
		  	if Regexp.new("^" + Regexp.escape(m.bot.nick + ":" )) =~ m.message
		  		m.reply @markov.generate_n_sentences(1)
		  	elsif m.message.match /(https?:\/\/[^\s]+)/ # return on urls
		  		return
		  	else
		  		@markov.parse_string(m.message)
		  	end
		  end

		  def save_dict
		  	@markov.save_dictionary!
		  end

		end
	end
end